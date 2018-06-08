class ArticlesController < ApplicationController
  
  #Make sure the before actions are in the correct order or you may run into problems
  #Making certain actions call this method as it was repeated
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  #All actions to do with articles except index and show require you to be logged in
  before_action :require_user, except: [:index, :show]
  #Only users that created their own articles can edit, update and delete them
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  #Index is the list of articles
  def index
    #Getting articles from the database, paginate only list so many rather than all of them, dont always need per_page as it has a default
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  #New article action
  def new
    #This declares the @article variable over on the view
    @article = Article.new
  end
  
  #edit article action
  def edit
  end
  
  #create article action
  def create
    #This creates a new article with a different id
    @article = Article.new(article_params)
    #Making the current user the person who created the article
    @article.user = current_user
    #If all good save article
    if @article.save
      #Flash displays message, changed the notice to success
      flash[:success] = "Article was successfully created"
      #Then we redirect user to the article that they have created
      redirect_to article_path(@article)
    #If not all good render new article page
    else
      render 'new'
    end
  end
  
  #update article action
  def update
    #Find the article that needs to be updated
    #If all good update article, need to tell what we updated
    if @article.update(article_params)
      #Message to user
      flash[:success] = "Article was successfully updated"
      #Redirect user to article that they have just edited
      redirect_to article_path(@article)
    #If can't update render the edit page
    else
      render 'edit'
    end
  end
  
  #Show article action
  def show
    #Find articles and display them
  end
  
  #Delete article action, Note this needs to be called destroy or it wont work
  def destroy
    #Find article to delete
    #Delete the article
    @article.destroy
    #Notify user article was deleted
    flash[:danger] = "Article was successfully deleted"
    #Redirect user to the index page
    redirect_to articles_path
  end
  
  private
    #Set_article method, removes repeated code
    def set_article
      @article = Article.find(params[:id])
    end
    
    #Article_params method, removes repeated code
    def article_params
      params.require(:article).permit(:title, :description)
    end
  
    #Method to add in restrictions, allows admin or users who created them to edit or delete them
    def require_same_user
      #If current user does not match the admin or user who created that article
      if current_user != @article.user and !current_user.admin?
        #Display message
        flash[:danger] = "You can only edit or delete your own articles"
        #Redirect them to the root path, in this case it will be the list of articles
        redirect_to root_path
      end
    end
  
end