class Forum::TagsController < ApplicationController
  def index
    authorize Forum::Tag
  end

  def show
    @tag = Forum::Tag.find(params[:id])
  end

  def new
    authorize Forum::Tag
    @tag = Forum::Tag.new
    render 'form'
  end

  def create
    authorize Forum::Tag
    @tag = Forum::Tag.new tag_params
    if @tag.save
      redirect_to forum_tags_path
    else
      render 'form'
    end
  end

  def edit
    @tag = Forum::Tag.find(params[:id])
    authorize @tag
    render 'form'
  end

  def update
    @tag = Forum::Tag.find(params[:id])
    authorize @tag

    if @tag.update(tag_params)
      redirect_to forum_tags_path
    else
      render 'form'
    end
  end

  def destroy
    @tag = Forum::Tag.find(params[:id])
    authorize @tag
    @tag.destroy

    redirect_to forum_tags_path
  end


  private
  def tag_params
    params.require(:forum_tag).permit(:name)
  end



end
