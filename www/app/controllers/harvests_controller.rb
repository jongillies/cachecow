class HarvestsController < ApplicationController

  respond_to :html, :json

  def index
    respond_with(@harvests = Harvest.all)
  end

  def show
    respond_with(@harvest = Harvest.find(params[:id]))
  end

  def create
    crop_id = Crop.where(crop_number: params[:crop_number]).limit(1)[0].id
    @harvest = Harvest.new(params[:harvest].merge(crop_id: crop_id))
    flash[:notice] = "Harvester log was successfully created." if @harvest.save
    respond_with(@harvest)
  end

end