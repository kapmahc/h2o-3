class Forum::ArticlesController < ApplicationController
  def index
    authorize Forum::Article
    if current_user.is_admin?
      @articles = Forum::Article.all.order(updated_at: :desc)
    else
      @articles = Forum::Article.where(user_id: current_user.id).order(updated_at: :desc)
    end
  end

  def show
    @article = Forum::Article.find(params[:id])
  end


  def new
    authorize Forum::Article
    @article = Forum::Article.new format: 'markdown'
    render 'form'
  end

  def create
    authorize Forum::Article
    @article = Forum::Article.new article_params
    @article.user_id = current_user.id
    if @article.save
      redirect_to forum_articles_path
    else
      render 'form'
    end
  end

  def edit
    @article = Forum::Article.find(params[:id])
    authorize @article
    render 'form'
  end

  def update
    @article =  Forum::Article.find(params[:id])
    authorize @article

    if @article.update(article_params)
      redirect_to forum_articles_path
    else
      render 'form'
    end
  end

  def destroy
    @article =  Forum::Article.find(params[:id])
    authorize @article
    @article.destroy

    redirect_to forum_articles_path
  end


  private
  def article_params
    params.require(:forum_article).permit(:title, :body, :format, forum_tag_ids: [])
  end
end
