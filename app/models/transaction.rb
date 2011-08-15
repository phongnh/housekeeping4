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

  # TODO: Change owner to payee
  belongs_to :owner, :class_name => "User", :foreign_key => :owner_id
  belongs_to :account
  belongs_to :category

  delegate :name, :to => :account, :prefix => :account
  delegate :name, :to => :category, :prefix => :category
  
  # TODO: Use other name for included scope
  scope :included, includes(:account, :category)
  scope :recent, includes(:account, :category).order("date DESC, created_at DESC")

  # TODO: Add more validation of account_id and category_id
  validates :account_id, :date, :category_id, :amount, :kind, :presence => true
  validates :amount,
            :numericality => { :only_integer => true, :allow_nil => true },
            :length       => { :maximum => 15, :allow_nil => true }
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
    TYPES[kind]
  end

  def save_and_update_account!
    self.class.transaction do
      self.update_date
      self.save!
      self.update_account!
    end
    self
  end

  protected

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

