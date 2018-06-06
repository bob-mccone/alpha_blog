#Log in controller
class SessionsController < ApplicationController
  
  #New method for user log in
  def new
    
  end
  
  #Create method for user log in
  def create
    #Find user based on their email address that they have entered
    user = User.find_by(email: params[:session][:email].downcase)
    #Checking if email entered is valid
    if user && user.authenticate(params[:session][:password])
      #Saving the user id in the browser for cookies
      session[:user_id] = user.id
      #If valid display message
      flash[:success] = "You have successfully logged in"
      #Then redirect to users page
      redirect_to user_path(user)
    #Else if it failed display the message
    else
      #Flash now only works there and then rather than on all pages kind of thing
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
  end
  
  #Destroy method for user log out
  def destroy
    #Setting the session to nil
    session[:user_id] = nil
    #Display message to show they have now logged out
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
  
end