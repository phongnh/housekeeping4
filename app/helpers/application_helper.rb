module ApplicationHelper
  def human_field_name(field, klass=ActiveRecord::Base, required=nil)
    [klass.human_attribute_name(field), required].reject{|e| e.blank?}.join("")
  end

  #def to_currency(amount)
    #number_to_currency amount, :locale => :vi, :precision => 0,
                       #:unit => "VND", :format => "%n %u", :delimiter => "."
  #end

  def to_currency(amount)
    number_to_currency amount, :precision => 0
  end
end
