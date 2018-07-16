class CategoriesController < ApplicationController
  #Index categories controller
  def index
    #If we want pagination
    @categories = Category.paginate(page: params[:page], per_page: 5)
    #If not paginate
    #@categories = Category.all

  end
  
  #New categories controller
  def new
    @category = Category.new
  end
  
  #Create categories controller
  def create
    @category = Category.new(category_params)
    #If save was successful
    if @category.save
      #Display message
      flash[:success] = "Category was created successfully"
      #Then redirect them to the categories index page
      redirect_to categories_path
    else
      #Else render the new categories page
      render 'new'
    end
  end
  
  #Show categories controller
  def show
    
  end
  
  private
  def category_params
    params.require(:category).permit(:name)
  end
end