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
  scope :root, where(:parent_id => nil)

  validates :name, :presence => true, :uniqueness => true

  has_many :transactions

  #def self.seed
    #categories = [
      #{ :name => "Auto & Transport" },
      #{ :name => "Bills & Utilities" },
      #{ :name => "Business Services" },
      #{ :name => "Education" },
      #{ :name => "Entertainment" },
      #{ :name => "Fees & Charges" },
      #{ :name => "Financial" },
      #{ :name => "Food & Dining" },
      #{ :name => "Gifts & Donations" },
      #{ :name => "Health & Fitness" },
      #{ :name => "Home" },
      #{ :name => "Income" },
      #{ :name => "Investments" },
      #{ :name => "Kids" },
      #{ :name => "Personal Care" },
      #{ :name => "Pets" },
      #{ :name => "Shopping" },
      #{ :name => "Taxes" },
      #{ :name => "Transfer" },
      #{ :name => "Travel" },
      #{ :name => "Uncategorized" }
    #]
    #self.create(categories)
  #end

  def self.seed
    categories = [
      { :name => "Xe cộ và Vận chuyển" },
      { :name => "Hóa đơn & Thanh toán" },
      { :name => "Giáo dục" },
      { :name => "Giải trí" },
      { :name => "Phí dịch vụ" },
      { :name => "Tài chính" },
      { :name => "Thực phẩm & Tiêu dùng" },
      { :name => "Quà tặng & Từ thiện" },
      { :name => "Sức khỏe & Y tế" },
      { :name => "Nhà cửa & Nội thất" },
      { :name => "Lương" },
      { :name => "Tiền thưởng" },
      { :name => "Tiền lãi" },
      { :name => "Tiền vay" },
      { :name => "Nợ trả" },
      { :name => "Cho vay/mượn" },
      { :name => "Đầu tư" },
      { :name => "Con cái" },
      { :name => "Làm đẹp" },
      { :name => "Vật nuôi" },
      { :name => "Mua sắm" },
      { :name => "Thuế" },
      { :name => "Du lịch" },
      { :name => "Chưa phân loại" }
    ]
    self.create(categories)
  end

end

