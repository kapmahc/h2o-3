class LeaveWordsController < ApplicationController

  def index
    authorize :dashboard, :admin?
    @leave_words = LeaveWord.all
  end

  def new
    @leave_word = LeaveWord.new
    authorize @leave_word
  end

  def create
    authorize :dashboard, :admin?
    @leave_word = LeaveWord.new params.require(:leave_word).permit(:body)

    if @leave_word.save
      flash[:notice] = t 'messages.success'
      redirect_to new_leave_word_path
    else
      render 'new'
    end
  end

  def destroy
    authorize :dashboard, :admin?
    @leave_word = LeaveWord.find params.fetch(:id)
    @leave_word.destroy
    redirect_to leave_words_path
  end

end
