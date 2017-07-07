class Survey::RecordsController < ApplicationController
  before_action :require_admin!, except: [:new, :create]

  def index
    @form = Survey::Form.find params.fetch(:form_id)
  end

  def new
    @form = Survey::Form.find params.fetch(:form_id)
  end

  def create
    form = Survey::Form.find params.fetch(:form_id)

    record = Survey::Record.new
    record.client_ip = request.remote_ip
    record.survey_form_id = params.fetch(:form_id)
    record.value = form.survey_fields.reduce({}) {|h, v| h.merge(v.name => params.fetch(v.name))}.to_json

    if record.save
      flash[:notice] = t 'messages.success'
      redirect_to new_survey_form_record_path(form)
    else
      render 'new'
    end
  end

  def destroy
    @record = Survey::Record.find(params[:id])
    @record.destroy

    redirect_to survey_form_records_path(form_id:params.fetch(:form_id))

  end
end
