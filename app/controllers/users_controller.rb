class UsersController < ApplicationController
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
  
  private
  #User parameters
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end