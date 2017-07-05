class Forum::TagsController < ApplicationController
  def index
    authorize Forum::Tag
  end


  def new
    @tag = Forum::Tag.new
    render 'form'
  end

  def create
    @tag = Forum::Tag.new tag_params
    if @tag.save
      redirect_to forum_tags_path
    else
      render 'form'
    end
  end

  def edit
    @tag = Forum::Tag.find(params[:id])
    render 'form'
  end

  def update
    @tag = Forum::Tag.find(params[:id])

    if @tag.update(tag_params)
      redirect_to forum_tags_path
    else
      render 'form'
    end
  end

  def destroy
    @tag = Forum::Tag.find(params[:id])
    @tag.destroy

    redirect_to forum_tags_path
  end


  private
  def tag_params
    params.require(:forum_tag).permit(:name)
  end



end
