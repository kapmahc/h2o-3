class Survey::FieldsController < ApplicationController
  before_action :require_admin!

  def index
    @form = Survey::Form.find params[:form_id]
  end

  def new
    @field = Survey::Field.new survey_form_id: params.fetch(:form_id), sort_order: 0, flag: 'text'
    render 'form'
  end

  def create
    @field = Survey::Field.new field_params
    @field.survey_form_id = params.fetch(:form_id)
    if @field.save
      redirect_to survey_form_fields_path(@field.survey_form_id)
    else
      render 'form'
    end
  end

  def edit
    @field = Survey::Field.find(params[:id])
    render 'form'
  end

  def update
    @field = Survey::Field.find(params[:id])

    if @field.update(field_params)
      redirect_to survey_form_fields_path(@field.survey_form_id)
    else
      render 'form'
    end
  end

  def destroy
    @field= Survey::Field.find(params[:id])
    @field.destroy

    redirect_to survey_form_fields_path(@field.survey_form_id)
  end

  private
  def field_params
    params.require(:survey_field).permit(:name, :label, :flag, :value, :help, :options, :sort_order)
  end

end
