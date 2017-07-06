class Survery::FieldsController < ApplicationController
  before_action :require_admin!

  def index
    @form = Survery::Form.find params[:form_id]
  end

  def new
    @field = Survery::Field.new survery_form_id: params.fetch(:form_id), sort_order: 0, flag: 'text'
    render 'form'
  end

  def create
    @field = Survery::Field.new field_params
    @field.survery_form_id = params.fetch(:form_id)
    if @field.save
      redirect_to survery_form_fields_path(@field.survery_form_id)
    else
      render 'form'
    end
  end

  def edit
    @field = Survery::Field.find(params[:id])
    render 'form'
  end

  def update
    @field = Survery::Field.find(params[:id])

    if @field.update(field_params)
      redirect_to survery_form_fields_path(@field.survery_form_id)
    else
      render 'form'
    end
  end

  def destroy
    @field= Survery::Field.find(params[:id])
    @field.destroy

    redirect_to survery_form_fields_path(@field.survery_form_id)
  end

  private
  def field_params
    params.require(:survery_field).permit(:name, :label, :flag, :value, :help, :options, :sort_order)
  end

end
