require 'test_helper'
#Category controller testing
class CategoriesControllerTest < ActionController::TestCase
  #Need a setup method to get the category id
  def setup
    @category = Category.create(name: "sports")
  end
  
  #Test we have all the routes and that they are available
  #Index test
  test "should get categories index" do
    get :index
    assert_response :success
  end
  
  #New test
  test "should get new" do
    get :new
    assert_response :success
  end
  
  #Show test
  test "should get show" do
    #As this is show we need to pass in the id of the @category that we created
    get(:show, {'id' => @category.id})
    assert_response :success
  end
end