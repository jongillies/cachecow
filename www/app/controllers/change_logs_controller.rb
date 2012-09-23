class ChangeLogsController < ApplicationController

  respond_to :html, :json

  def index
    respond_with(@change_logs = ChangeLog.all)
  end

  def show
    respond_with(@change_log = ChangeLog.find(params[:id]))
  end

  def create
    crop_id = Crop.where(crop_number: params[:crop_number]).limit(1)[0].id
    @change_log = ChangeLog.new(params[:change_log].merge(crop_id: crop_id))
    flash[:notice] = "Change log was successfully created." if @change_log.save
    respond_with(@change_log)
  end

end