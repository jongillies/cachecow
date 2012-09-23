class HarvesterLogsController < ApplicationController

  respond_to :html, :json

  def index
    respond_with(@harvester_logs = HarvesterLog.all)
  end

  def show
    respond_with(@harvester_log = HarvesterLog.find(params[:id]))
  end

  def create
    crop_id = Crop.where(crop_number: params[:crop_number]).limit(1)[0].id
    @harvester_log = HarvesterLog.new(params[:harvester_log].merge(crop_id: crop_id))
    flash[:notice] = "Harvester log was successfully created." if @harvester_log.save
    respond_with(@harvester_log)
  end

end