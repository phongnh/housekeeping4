module ApplicationHelper
  def human_field_name(field, required=nil, klass=ActiveRecord::Base)
    [klass.human_attribute_name(field), required].reject{|e| e.blank?}.join("")
  end

  def to_currency(amount)
    number_to_currency amount, :locale => :vi, :precision => 0,
                       :unit => "VND", :format => "%n %u", :delimiter => "."
  end
end

