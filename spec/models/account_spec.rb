# == Schema Information
#
# Table name: accounts
#
#  id          :integer         not null, primary key
#  owner_id    :integer
#  name        :string(255)
#  default     :boolean         default(FALSE)
#  description :string(255)
#  income      :integer         default(0)
#  expenses    :integer         default(0)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Account do
  describe "Virtual Attributes / Instance Methods" do
    before :each do
      @account = Account.new
    end

    it "should have a balance method" do
      @account.should respond_to(:balance)
    end

    it "should have an owner method" do
      @account.should respond_to(:owner)
    end

    it "should have a transactions method" do
      @account.should respond_to(:transactions)
    end

    it "should have a daily_transactions method" do
      @account.should respond_to(:daily_transactions)
    end

    it "should have a monthly_transactions method" do
      @account.should respond_to(:monthly_transactions)
    end

    it "should have a yearly_transactions method" do
      @account.should respond_to(:yearly_transactions)
    end
  end

  describe "Class Methods" do

  end

  describe "#balance" do
    before :each do
      @account = Account.new :earnings => 100, :expenses => 50
    end

    it "should have value of earnings - expenses" do
      @account.should_receive(:earnings).and_return(100)
      @account.should_receive(:expenses).and_return(50)
      @account.balance.should == 50
    end
  end
end

