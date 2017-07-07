class Survey::FormsController < ApplicationController
  before_action :require_admin!

  def index

  end


  def new
    @form = Survey::Form.new format: 'markdown'
    render 'form'
  end

  def create
    @form = Survey::Form.new form_params
    if @form.save
      redirect_to survey_forms_path
    else
      render 'form'
    end
  end

  def edit
    @form = Survey::Form.find(params[:id])
    render 'form'
  end

  def update
    @form = Survey::Form.find(params[:id])

    if @form.update(form_params)
      redirect_to survey_forms_path
    else
      render 'form'
    end
  end

  def destroy
    @form= Survey::Form.find(params[:id])
    @form.destroy

    redirect_to survey_forms_path
  end


  private
  def form_params
    params.require(:survey_form).permit(:title, :format, :body, :start_up, :shut_down)
  end
end
