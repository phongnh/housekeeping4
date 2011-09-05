# encoding: utf-8
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
      { :name => "Xe cộ - Vận chuyển" },
      { :name => "Giáo dục - Học tập" },
      { :name => "Tiệc tùng - Hội họp - Vui chơi - Giải trí" },
      { :name => "Phí dịch vụ" },
      { :name => "Lương thực - Thực phẩm - Thức uống" },
      { :name => "Quà tặng - Từ thiện" },
      { :name => "Bảo hiểm - Sức khỏe - Y tế" },
      { :name => "Nhà cửa - Nội thất" },
      { :name => "Điện - Nước - Xăng - Gas" },
      { :name => "Đồ gia dụng - Điện tử" },
      { :name => "Lương cố định" },
      { :name => "Tiền làm thêm" },
      { :name => "Tiền hụi" },
      { :name => "Tiền thưởng" },
      { :name => "Tiền lãi" },
      { :name => "Tiền vay" },
      { :name => "Tiền thuê" },
      { :name => "Trả nợ" },
      { :name => "Cho vay/mượn" },
      { :name => "Con cái" },
      { :name => "Mua sắm - Làm đẹp" },
      { :name => "Cây cảnh - Vật nuôi" },
      { :name => "Du lịch" },
      { :name => "Chi phí khác" }
    ]
    self.create(categories)
  end

end

