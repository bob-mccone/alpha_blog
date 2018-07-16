require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  #Setup runs first then the test, this will test the data first then get rid of it
  def setup
    #Test category called sports
    @category = Category.new(name: "sports")
  end
  
  test "category should be valid" do
    #This is the test, can we initiate a new category instance variable and is it valid
    assert @category.valid?
  end
  
  #Can only create a category if name is valid
  test "name should be present" do
    @category.name = " "
    assert_not @category.valid?
  end
  
  #If name already exists then it stops duplication
  test "name should be unique" do
    @category.save
    category2 = Category.new(name: "sports")
    assert_not category2.valid?
  end
  
  #Name should not be longer than 26 characters
  test "name should not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end
  
  #Name should be at least 3 characters
  test "name should not be too short" do
    @category.name = "aa"
    assert_not @category.valid?
  end
  
end