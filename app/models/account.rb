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

  scope :default, where(:default => true)

  def balance
    earnings - expenses
  end

  private
end

