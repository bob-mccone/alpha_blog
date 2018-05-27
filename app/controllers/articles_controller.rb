class ArticlesController < ApplicationController
  
  #Index is the list of articles
  def index
    #Getting all articles from the database
    @articles = Article.all
  end
  
  #New article action
  def new
    #This declares the @article variable over on the view
    @article = Article.new
  end
  
  #edit article action
  def edit
    #This finds the article as we are trying to edit one already created
    @article = Article.find(params[:id])
  end
  
  #create article action
  def create
    #This creates a new article with a different id
    @article = Article.new(article_params)
    #If all good save article
    if @article.save
      #Flash displays message
      flash[:notice] = "Article was successfully created"
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
    @article = Article.find(params[:id])
    #If all good update article, need to tell what we updated
    if @article.update(article_params)
      #Message to user
      flash[:notice] = "Article was successfully updated"
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
    @article = Article.find(params[:id])
  end
  
  #Delete article action, Note this needs to be called destroy or it wont work
  def destroy
    #Find article to delete
    @article = Article.find(params[:id])
    #Delete the article
    @article.destroy
    #Notify user article was deleted
    flash[:notice] = "Article was successfully deleted"
    #Redirect user to the index page
    redirect_to articles_path
  end
  private
    def article_params
      params.require(:article).permit(:title, :description)
    end
  

  
end