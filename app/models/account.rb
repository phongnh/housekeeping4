# == Schema Information
#
# Table name: accounts
#
#  id          :integer         not null, primary key
#  owner_id    :integer
#  name        :string(255)
#  default     :boolean         default(FALSE)
#  description :string(255)
#  earnings    :integer         default(0)
#  expenses    :integer         default(0)
#  balance     :integer         default(0)
#  created_at  :datetime
#  updated_at  :datetime
#

class Account < ActiveRecord::Base
  has_many :transactions
  belongs_to :owner, :class_name => "User", :foreign_key => :owner_id


  before_save :update_balance

  scope :default, where(:default => true)

  private
  def update_balance
    self.balance = self.earnings - self.expenses
  end
end

