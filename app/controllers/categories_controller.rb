class CategoriesController < ApplicationController
  #Restrictions
  before_action :require_admin, except: [:index, :show]
  
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
  
  #Edit categories controller
  def edit
    #Finding the category to edit
    @category = Category.find(params[:id])
  end
  
  def update
    #Find the category to be updated
    @category = Category.find(params[:id])
    #If update was successful
    if @category.update(category_params)
      #Display message
      flash[:success] = "Category name was successfully updated"
      #Redirect them to the category show page
      redirect_to category_path(@category)
    else
      #Else if not successful render the category edit page again
      render 'edit'
    end
  end
  
  #Show categories controller
  def show
    #Category variable from the categories show file
    @category = Category.find(params[:id])
    #Category_articles variable from the categories show file and handles paginate
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end
  
  private
  def category_params
    params.require(:category).permit(:name)
  end
  
  def require_admin
    #If user is not logged in or they are logged in but not an admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      #Display message
      flash[:danger] = "Only admins can perform that action"
      #Redirect them to the categories index page
      redirect_to categories_path
    end
  end
end