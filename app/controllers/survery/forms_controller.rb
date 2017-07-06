class Survery::FormsController < ApplicationController
  before_action :require_admin!

  def index

  end


  def new
    @form = Survery::Form.new format: 'markdown'
    render 'form'
  end

  def create
    @form = Survery::Form.new form_params
    if @form.save
      redirect_to survery_forms_path
    else
      render 'form'
    end
  end

  def edit
    @form = Survery::Form.find(params[:id])
    render 'form'
  end

  def update
    @form = Survery::Form.find(params[:id])

    if @form.update(form_params)
      redirect_to survery_forms_path
    else
      render 'form'
    end
  end

  def destroy
    @form= Survery::Form.find(params[:id])
    @form.destroy

    redirect_to survery_forms_path
  end


  private
  def form_params
    params.require(:survery_form).permit(:title, :format, :body, :start_up, :shut_down)
  end
end
