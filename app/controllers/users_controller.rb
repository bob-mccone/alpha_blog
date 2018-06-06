class UsersController < ApplicationController
  
  #Make sure the before actions are in the correct order or you may run into problems
  #Making the @user variable ready for the following actions
  before_action :set_user, only: [:edit, :update, :show]
  #Adding restrictions so you can't edit other peoples profiles
  before_action :require_same_user, only: [:edit, :update]
  
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
  end
  
  #Updates the edited user
  def update
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
    #Pagination, getting all of the users articles but only showing certain ammount per page
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  private
  #User parameters method
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
  #Set_user method
  def set_user
    @user = User.find(params[:id])
  end
  
  #Require_same_user, adds restriction for what you can do with other profiles
  def require_same_user
    #If current logged in user does not match the user that is being edited
    if current_user !=@user
      #Display message
      flash[:danger] = "You can only edit your own account"
      #Redirect them to the logged in root path, in this case it will be the list of articles
      redirect_to root_path
    end
  end
end