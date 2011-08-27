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

  def show_pagination(collection, options={})
    content_tag :div, :class => "custom_pagination" do
      content_tag(:div, page_entries_info(collection), :class => "page_info") +
        will_paginate(collection, :inner_window => 2, :class => "pagination").to_s.html_safe
    end
  end
end
