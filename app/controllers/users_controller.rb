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
  
  private
  #New user parameters
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end