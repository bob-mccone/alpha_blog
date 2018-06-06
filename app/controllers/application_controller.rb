class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #Helper methods make methods available to all views
  helper_method :current_user, :logged_in?
  
  #Current_user method
  def current_user
    #Return this user if there is a user in our database, @current user stops it from hitting the database everytime, also known as optimization
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    
  end
  
  #logged_in method, see if user is logged in
  def logged_in?
    #Boolean to see if current user is logged in or not
    !!current_user
  end
  
  #Require_user method, certain actions are restricted based on wether they are logged in or not
  def require_user
    #If not logged in display message then return to home page
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
  
end
