class UsersController < ApplicationController
  
  #Displaying 5 users per page
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    #If save is successful display message and redirect them to the articles page
    if @user.save
      flash[:success] = "welcome to the alpha blog #{@user.username}"
      redirect_to articles_path
    else
      #Render create user form with error messages
      render 'new'
    end
  end
  
  #Finds the user to edit
  def edit
    @user = User.find(params[:id])
  end
  
  #Updates the edited user
  def update
    #Finds user that needs to be updated
    @user = User.find(params[:id])
    #If sucessful display message and redirect them to articles page
    if @user.update(user_params)
      flash[:success] = "Your account details were updated sucessfully"
      redirect_to articles_path
    else
      #Render edit form again with error messages
      render 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
    #Pagination, getting all of the users articles but only showing certain ammount per page
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  private
  #User parameters
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end