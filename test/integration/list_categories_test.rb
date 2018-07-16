require 'test_helper'
#Integration categories testing
class CreateCategoriesTest < ActionDispatch::IntegrationTest
  #setup method
  def setup
    @category = Category.create(name: "books")
    @category2 = Category.create(name: "programming")
  end
  
  test "should show categories listing" do
    #Get to the categories page
    get categories_path
    assert_template 'categories/index'
    #Test that the categories are being listed and they link to the categories show page
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end