class HarvestsController < ApplicationController

  respond_to :html, :json

  def index
    @q = Harvest.search(params[:q])
    @total = @q.result(:distinct => true).order("created_at DESC")
    @harvests =  @q.result.page(params[:page]).per(5)
    respond_with(@harvests)
  end

  def show
    respond_with(@harvest = Harvest.find(params[:id]))
  end

  def create
    @harvest = Harvest.new(params[:harvest])

    logger.fatal params[:harvest].inspect

    flash[:notice] = "harvest log was successfully created." if @harvest.save
    respond_with(@harvest)
  end
end