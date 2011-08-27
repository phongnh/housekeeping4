# == Schema Information
#
# Table name: transactions
#
#  id          :integer         not null, primary key
#  date        :date
#  year        :integer(2)
#  month       :integer(1)
#  day         :integer(1)
#  account_id  :integer
#  category_id :integer
#  owner_id    :integer
#  amount      :integer
#  description :string(255)
#  kind        :integer
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

class Transaction < ActiveRecord::Base
  #default_scope includes(:owner, :account, :category)
  #include ActionController::UrlWriter
  include Rails.application.routes.url_helpers
  self.per_page = 50

  before_create :update_date

  # TODO: Change owner to payee
  belongs_to :owner, :class_name => "User", :foreign_key => :owner_id
  belongs_to :account
  belongs_to :category

  delegate :name, :to => :account, :prefix => :account
  delegate :name, :to => :category, :prefix => :category

  scope :associated, includes(:account, :category)
  scope :with_categories, includes(:category)
  scope :ordered, order("date DESC, created_at DESC")
  scope :recent, associated.ordered

  # TODO: Add more validation of account_id and category_id
  validates :account_id, :date, :category_id, :amount, :kind, :presence => true
  validates :amount,
            :numericality => {
              :only_integer => true, :greater_than => 0, :allow_nil => true
            },
            :length => { :maximum => 15, :allow_nil => true }
  validates :kind, :inclusion => { :in => TYPES.keys }

  def is_income?
    kind == INCOME
  end

  def is_expense?
    kind == EXPENSE
  end

  def is_transfer?
    kind == TRANSFER
  end

  def kind_name
    I18n.t("transaction.type.#{TYPES[kind]}")
  end

  def formatted_date
    date.strftime("%d-%m-%Y")
  end

  def to_format(*args)
    options = args.extract_options!
    format = args.first || :csv
    send("to_#{format}_format", options)
  end

  def save_and_update_account!
    self.class.transaction do
      #self.valid?
      #self.update_date
      self.save!
      self.update_account!
    end
    self
  end

  def self.save_and_update_account!(transaction_params)
    new(transaction_params).save_and_update_account!
  end

  def self.csv_header(delimiter=",")
    header.join(delimiter)
  end

  def self.by_account_id(*args)
    options = args.extract_options!
    accounts = Account.select([:id, :name]).all
    account_id = options[:account_id].to_i
    page = options[:page]

    # Account is 'all'
    if account_id == 0
      transactions = self.where(:account_id => accounts.map(&:id)).
                          with_categories.ordered.page(page).all
    else
      transactions = []
      account = accounts.detect{ |a| a.id == account_id }
      transactions = account.transactions.with_categories.page(page).all if account
    end

    transaction_sizes = self.where(:account_id => accounts.map(&:id)).
                             group(:account_id).count

    accounts_hash = accounts.inject({}) { |h, a| h[a.id] = a; h }

    transaction_sizes.each { |k, v| accounts_hash[k].transactions_size = v }

    accounts.insert 0, Account.create_total_account(transaction_sizes.values.sum)
    [accounts, transactions]
  end

  protected

  def self.header
    ["Date", "Account", "Category", "Kind", "Amount", "Description"]
  end

  def to_exported_format
    [formatted_date, account_name, category_name, kind_name, amount, description]
  end

  def to_csv_format(options)
    delimiter = options[:delimiter] || ","
    to_exported_format.join(delimiter)
  end

  def update_date
    self.year  = self.date.year
    self.month = self.date.month
    self.day   = self.date.day
  end

  def update_account!
    # TODO: Use public api of account model for changing account's income and expense
    account = self.account
    options = if self.is_income?
      { :income  => self.amount + account.income  }
    else
      { :expense => self.amount + account.expense }
    end
    account.update_attributes! options
  end
end

