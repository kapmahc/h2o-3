class Survery::RecordsController < ApplicationController
  before_action :require_admin!, except: [:new, :create]

  def index
    @form = Survery::Form.find params.fetch(:form_id)
  end

  def new
    @form = Survery::Form.find params.fetch(:form_id)
  end

  def create
    form = Survery::Form.find params.fetch(:form_id)

    record = Survery::Record.new
    record.client_ip = request.remote_ip
    record.survery_form_id = params.fetch(:form_id)
    record.value = form.survery_fields.reduce({}) {|h, v| h.merge(v.name => params.fetch(v.name))}.to_json

    if record.save
      flash[:notice] = t 'messages.success'
      redirect_to new_survery_form_record_path(form)
    else
      render 'new'
    end
  end

  def destroy
    @record = Survery::Record.find(params[:id])
    @record.destroy

    redirect_to survery_form_records_path(form_id:params.fetch(:form_id))

  end
end
