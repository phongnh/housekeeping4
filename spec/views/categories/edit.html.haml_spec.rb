require 'spec_helper'

describe "categories/edit.html.haml" do
  before(:each) do
    @category = assign(:category, stub_model(Category,
      :name => "MyString",
      :category_type => 1
    ))
  end

  it "renders the edit category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => categories_path(@category), :method => "post" do
      assert_select "input#category_name", :name => "category[name]"
      assert_select "input#category_category_type", :name => "category[category_type]"
    end
  end
end
