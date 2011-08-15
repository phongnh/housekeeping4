# == Schema Information
#
# Table name: account_types
#
#  id   :integer         not null, primary key
#  name :string(255)
#

class AccountType < ActiveRecord::Base
  has_many :accounts

  validates :name, :presence => true, :uniqueness => true

  def self.seed
    types = [
      { :name => "Cash" },
      { :name => "Checking" },
      { :name => "Savings" },    
      { :name => "Credit Card" },
      { :name => "Investment" },
      { :name => "Liability" },
      { :name => "Other" }
    ]
    self.create types
  end
end
