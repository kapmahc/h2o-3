class LeaveWordsController < ApplicationController

  def index
    @leave_words = LeaveWord.all
    authorize @leave_words
  end

  def new
    @leave_word = LeaveWord.new
    authorize @leave_word
  end

  def create
    @leave_word = LeaveWord.new params.require(:leave_word).permit(:body)
    authorize @leave_word

    if @leave_word.save
      flash[:notice] = t 'messages.success'
      redirect_to new_leave_word_path
    else
      render 'new'
    end
  end

  def destroy
    @leave_word = LeaveWord.find params.fetch(:id)
    authorize @leave_word
    @leave_word.destroy
    redirect_to leave_words_path
  end

end
