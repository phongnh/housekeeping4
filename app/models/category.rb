# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  color      :string(255)     default("white")
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  default_scope order(:name)
  scope :root, where(:parent_id => nil)

  def self.seed
    categories = [
      { :name => "Auto & Transport" },
      { :name => "Bills & Utilities" },
      { :name => "Business Services" },
      { :name => "Education" },
      { :name => "Entertainment" },
      { :name => "Fees & Charges" },
      { :name => "Financial" },
      { :name => "Food & Dining" },
      { :name => "Gifts & Donations" },
      { :name => "Health & Fitness" },
      { :name => "Home" },
      { :name => "Income" },
      { :name => "Investments" },
      { :name => "Kids" },
      { :name => "Personal Care" },
      { :name => "Pets" },
      { :name => "Shopping" },
      { :name => "Taxes" },
      { :name => "Transfer" },
      { :name => "Travel" },
      { :name => "Uncategorized" }
    ]
    self.create(categories)
  end
end

