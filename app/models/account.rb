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

  def self.transfer(option)
    from   = option[:from]
    to     = option[:to]
    amount = option[:amount]

    from = Account.find(from) unless from.instance_of? Account
    to   = Account.find(to) unless to.instance_of? Account

    from.transfer!(to, amount, option[:date])
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

  protected

  def create_transaction!(option)
    transaction = self.transactions.build option
    transaction.save!
    transaction
  end
end

