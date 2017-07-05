class Forum::CommentsController < ApplicationController
  def index
    authorize Forum::Comment

    if current_user.is_admin?
      @comments = Forum::Comment.all.order(updated_at: :desc)
    else
      @comments = Forum::Comment.where(user_id: current_user.id).order(updated_at: :desc)
    end
  end


  def new
    authorize Forum::Comment
    @comment = Forum::Comment.new format: 'markdown', forum_article_id: params.fetch(:forum_article_id)
    render 'form'
  end

  def create
    authorize Forum::Comment
    @comment = Forum::Comment.new params.require(:forum_comment).permit(:format, :body, :forum_article_id)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to forum_article_path(@comment.forum_article_id)
    else
      render 'form'
    end
  end

  def edit
    @comment = Forum::Comment.find(params[:id])
    authorize @comment
    render 'form'
  end

  def update
    @comment = Forum::Comment.find(params[:id])
    authorize @comment

    if @comment.update(params.require(:forum_comment).permit(:format, :body))
      redirect_to forum_article_path(@comment.forum_article_id)
    else
      render 'form'
    end
  end

  def destroy
    @comment = Forum::Comment.find(params[:id])
    authorize @comment
    @comment.destroy

    redirect_to forum_comments_path
  end



end
