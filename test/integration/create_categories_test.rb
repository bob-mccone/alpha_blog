require 'test_helper'
#Integration categories testing
class CreateCategoriesTest < ActionDispatch::IntegrationTest
  #Creating the admin user so test will pass
  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end
  #Test for valid data
  test "get new category form and create category" do
    #Log in the user
    sign_in_as(@user, "password")
    #Going to new category path
    get new_category_path
    #Getting the new form
    assert_template 'categories/new'
    #Posting to the new form and creating the category sports
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: "sports"}
    end
    #Redirecting you to the index page
    assert_template 'categories/index'
    #Display sports category on the index page
    assert_match "sports", response.body
  end
  #Test for invalid data
  test "invalid category submission results in failure" do
    #Log in the user
    sign_in_as(@user, "password")
    #Going to new category path
    get new_category_path
    #Getting the new form
    assert_template 'categories/new'
    #Dont want a change in category.count
    assert_no_difference 'Category.count' do
      #Dont need to redirect them, we are asserting the new template again, better syntax
      post categories_path, category: {name: " "}
    end
    #Redirecting you to the new page
    assert_template 'categories/new'
    #Validation messages display
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end