# == Schema Information
#
# Table name: transactions
#
#  id          :integer         not null, primary key
#  date        :date
#  account_id  :integer
#  category_id :integer
#  owner_id    :integer
#  amount      :integer
#  description :string(255)
#  kind        :integer         default(0)
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

class Transaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :account

  default_scope order([:date, :created_at])

  def kind_name
    I18n.t("label.#{TYPES[self.kind]}")
  end
end

