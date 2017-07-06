class AttachmentsController < ApplicationController
  def index
    authorize Attachment

    if current_user.is_admin?
      @attachments = Attachment.all.order(updated_at: :desc)
    else
      @attachments = Attachment.where(user_id: current_user.id).order(updated_at: :desc)
    end
  end

  def create
    authorize Attachment

    file = params.fetch(:file)
    @attachment = Attachment.new title: file.original_filename, content_type: file.content_type, user_id: current_user.id
    @attachment.avatar = file

    if @attachment.save
      redirect_to attachments_path
    else
      render 'new'
    end
  end


  def destroy
    @attachment = Attachment.find(params[:id])
    authorize @attachment
    @attachment.destroy

    redirect_to attachments_path
  end


end
