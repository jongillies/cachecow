class HarvestsController < ApplicationController

  respond_to :html, :json

  def index
    @q = Harvest.search(params[:q])
    @total = @q.result(:distinct => true).order("created_at DESC")
    @harvests = @total.paginate(page: params[:page])
    respond_with(@harvests)
  end

  def show
    respond_with(@harvest = Harvest.find(params[:id]))
  end

  def create
    @harvest = Change.new(params[:harvest])
    flash[:notice] = "Change was successfully created." if @harvest.save
    respond_with(@harvest)
  end

end