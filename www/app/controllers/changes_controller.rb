class ChangesController < ApplicationController

  respond_to :html, :json

  def index
    @q = Change.search(params[:q])
    @total = @q.result(:distinct => true).order("created_at DESC")
    @changes = @total.paginate(page: params[:page])
    respond_with(@changes)
  end

  def show
    respond_with(@change = Change.find(params[:id]))
  end

  def create
    crop_id = Crop.where(crop_number: params[:crop_number]).limit(1)[0].id
    @change = Change.new(params[:change].merge(crop_id: crop_id))
    flash[:notice] = "Change log was successfully created." if @change.save
    respond_with(@change)
  end

end