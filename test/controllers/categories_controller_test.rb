require 'test_helper'
#Category controller testing
class CategoriesControllerTest < ActionController::TestCase
  #Setup method
  def setup
    #Creating a category at start up
    @category = Category.create(name: "sports")
    #Creating an admin user at start up
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end
  
  #Test we have all the routes and that they are available
  #Index test
  test "should get categories index" do
    get :index
    assert_response :success
  end
  
  #New test
  test "should get new" do
    #Simulating a logged in admin user
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end
  
  #Show test
  test "should get show" do
    #As this is show we need to pass in the id of the @category that we created
    get(:show, {'id' => @category.id})
    assert_response :success
  end
  
  #Admin test
  test "should redirect create when admin not logged in" do
    #Don't change the count
    assert_no_difference 'Category.count' do
      #When this happens
      post :create, category: { name: "sports" }
    end
    #Redirect user
    assert_redirected_to categories_path
  end
end