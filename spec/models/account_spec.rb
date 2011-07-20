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

require 'spec_helper'

describe Account do
  pending "add some examples to (or delete) #{__FILE__}"
end
