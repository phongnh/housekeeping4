# == Schema Information
#
# Table name: accounts
#
#  id              :integer         not null, primary key
#  owner_id        :integer
#  account_type_id :integer
#  name            :string(255)
#  default         :boolean         default(FALSE)
#  description     :string(255)
#  income          :integer         default(0)
#  expense         :integer         default(0)
#  created_at      :datetime
#  updated_at      :datetime
#

class Account < ActiveRecord::Base
  DEFAULT_SELECT = "transactions.*, SUM(amount) AS sum_amount"

  belongs_to :owner, :class_name => "User", :foreign_key => :owner_id
  belongs_to :account_type

  has_many :transactions
  has_many :daily_transactions,
           :class_name => "Transaction",
           :foreign_key => :account_id,
           :group => [:kind, :date],
           :conditions => { :date => Date.today },
           :select => DEFAULT_SELECT
  has_many :monthly_transactions,
           :class_name => "Transaction",
           :foreign_key => :account_id,
           :group => [:kind, :year, :month],
           :conditions => {
             :year => Date.today.year,
             :month => Date.today.month
           },
           :select => DEFAULT_SELECT
  has_many :yearly_transactions,
           :class_name => "Transaction",
           :foreign_key => :account_id,
           :group => [:kind, :year],
           :conditions => { :year => Date.today.year },
           :select => DEFAULT_SELECT

  delegate :name, :to => :account_type, :prefix => :type

  scope :associated, includes(:account_type)
  scope :default, where(:default => true)

  validates :owner_id, :account_type_id, :name, :presence => true
  validates :name, :uniqueness => { :scope => [:owner_id] }

  # TODO: Remove changing account's expense and income directly
  attr_accessible :owner_id, :account_type_id, :name, :description, :expense, :income

  def transferable?(amount)
    balance >= amount
  end

  def balance
    income - expense
  end

  def exported_name
    name.strip.gsub(/\s+/, "_")
  end

  def export!(file_name)
    transactions = self.transactions
    path = "#{Rails.root}/tmp/#{file_name}"
    file = File.new(path, "r")
    file.puts Transaction.csv_header("\t")
    transactions.each do |t|
      file.puts t.to_format(:csv, :delimiter => "\t")
    end
    file.close
  end

  # TODO: Support importing statements from multi-account
  def import!(path)
    data = self.class.read_text_file(path)
    # Only process 20 data rows now
    # TODO: Remove limit of the number of data rows later
    data          = data[0...20]
    total_income  = 0
    total_expense = 0
    transactions  = []
    # Cache found categories
    categories    = {}
    data.each do |d|
      # Find category which transaction belongs to
      category_name = d.delete(:category_name)
      category = categories[category_name] || Category.find_by_name(category_name)
      categories[category_name] = category

      # Not support yet creating user's category
      # TODO: Need to allow user to create own category of user
      d.merge! :category => category, :account_id => self.id
      transaction = Transaction.new(d)
      # Not support yet transfer type of transaction
      valid = transaction.valid?
      next if !valid || (valid && transaction.is_transfer?)
      transactions << transaction
      if transaction.is_income?
        total_income += transaction.amount
      else # transaction.is_expense?
        total_expense += transaction.amount
      end
    end
    self.class.transaction do
      transactions.each(&:save!)
      self.update_attributes! :income => total_income, :expense => total_expense
    end
    self
  end

  def export
    transactions = self.transactions.associated.ordered
    self.class.export(transactions, "#{exported_name}_#{Time.now.to_i}.csv")
  end

  def self.export(transactions, file_name)
    file = File.new(file_name, "w")

    data = transactions.collect { |t| t.to_format(:csv, :delimiter => "\t") }.join("\n")

    file.puts Transaction.csv_header("\t")
    file.puts data

    file.close
  end

  def self.read_text_file(path, delimiter=";")
    # TODO: Need to check format data before importing
    f = File.open(path, "r")
    data = f.readlines
    data.collect! do |line|
      columns = line.chomp.split(delimiter)
      columns[DATE] = begin
                        Date.strptime(columns[DATE], "%d-%m-%Y")
                      rescue
                        Date.strptime(columns[DATE], "%d/%m/%Y")
                      end
      # Leave model process validating
      {
        :kind          => columns[KIND].to_i,
        :date          => columns[DATE],
        :category_name => columns[CATEGORY_NAME],
        # TODO: Need to support amount in format of float later
        :amount        => columns[AMOUNT].to_i,
        :description   => columns[DESCRIPTION]
      }
    end
    f.close
    data
  end

  def transfer!(other_account, amount, date)
    raise Exception if self == other_account
    self.class.transaction do
      raise Exception unless self.transferable? amount
      self.update_attributes! :expense => self.expense + amount
      other_account.update_attributes! :income => other_account.income + amount
      option = {
        :date        => date,
        # TODO: Use right category for transfering money between accounts
        :category_id => Category.first.id,
        :amount      => amount,
        :kind        => TRANSFER,
        :description => I18n.t("transaction.transfer", :account => other_account.name)
      }
      self.create_transaction! option
      option.merge! :description => I18n.t("transaction.receive", :account => self.name)
      other_account.create_transaction! option
    end
    true
  end

  def self.transfer(options)
    from   = options[:from]
    to     = options[:to]
    amount = options[:amount]

    from = Account.find(from) unless from.instance_of? Account
    to   = Account.find(to) unless to.instance_of? Account

    from.transfer!(to, amount, options[:date])
  end

  protected

  def create_transaction!(options)
    transaction = self.transactions.build options
    transaction.save!
    transaction
  end
end

