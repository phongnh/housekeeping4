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
#  reporter_id :integer
#  payee_id    :integer
#  amount      :integer
#  description :string(255)
#  kind        :integer
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Transaction do
  pending "add some examples to (or delete) #{__FILE__}"
end
