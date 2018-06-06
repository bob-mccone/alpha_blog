class PagesController < ApplicationController
  
  def home
    #If user is logged in then redirect them to the article page
    redirect_to articles_path if logged_in?
  end
  
  def about
    
  end
  
end