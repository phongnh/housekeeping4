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

require 'spec_helper'

describe Category do
  pending "add some examples to (or delete) #{__FILE__}"
end
