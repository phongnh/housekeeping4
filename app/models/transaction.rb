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
  belongs_to :category
  belongs_to :account
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"


  before_create :update_date
  after_create :update_account

  validates :account_id, :date, :category_id, :amount, :kind, :presence => true
  validates :amount,
            :numericality => { :only_integer => true, :allow_nil => true },
            :length       => { :maximum => 15, :allow_nil => true }
  validates :kind, :inclusion => { :in => TYPES.keys }

  scope :recent, includes(:category, :account).order("date DESC, created_at DESC")

  def self.summary(account_id)
    t = Date.today
    total      = Transaction.where(:account_id => account_id)
    this_year  = total.where(:year => t.year)
    this_month = this_year.where(:month => t.month)
    today      = this_month.where(:day => t.day)
    result = {}
    { :total => total, :this_year => this_year,
      :this_month => this_month, :today => today }.each do |key, value|
      new_value = value.all
      incoming = new_value.find_all(&:incoming?).sum(&:amount)
      outgoing = new_value.find_all(&:outgoing?).sum(&:amount)
      result[key] = {
        :incoming => incoming,
        :outgoing => outgoing,
        :balance  => incoming - outgoing
      }
    end
    result
  end

  def self.today
    transactions = Transaction.where(:date => Date.today).all
    Summary.new transactions
  end

  def self.this_month
    transactions = Transaction.where(:year  => Date.today.year,
                                     :month => Date.today.month).all
    Summary.new transactions
  end

  def self.this_year
    transactions = Transaction.where(:year => Date.today.year).all
    Summary.new transactions
  end

  def summary

  end

  def incoming?
    kind == INCOMING
  end

  def outgoing?
    kind == OUTGOING
  end

  def kind_name
    I18n.t("label.#{TYPES[self.kind]}")
  end

  private

  def update_date
    self.year  = self.date.year
    self.month = self.date.month
    self.day   = self.date.day
  end

  def update_account
    my_account = self.account
    if self.incoming?
      options  = { :earnings => my_account.earnings + self.amount }
    else
      options  = { :expenses => my_account.expenses + self.amount }
    end
    my_account.update_attributes options
  end
end

