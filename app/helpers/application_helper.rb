module ApplicationHelper
  def human_field_name(field, required=nil, klass=ActiveRecord::Base)
    [klass.human_attribute_name(field), required].reject{|e| e.blank?}.join("")
  end
end

