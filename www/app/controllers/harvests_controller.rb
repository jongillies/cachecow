class HarvestsController < ApplicationController

  respond_to :html, :json

  def index
    @q = Harvest.search(params[:q])
    @total = @q.result(:distinct => true).order("created_at DESC")
    @harvests = @total.paginate(page: params[:page])
    respond_with(@harvests)
  end

  def show
    respond_with(@crop = Harvest.find(params[:id]))
  end

  def create
    @crop = Change.new(params[:crop])
    flash[:notice] = "Change was successfully created." if @crop.save
    respond_with(@crop)
  end

end