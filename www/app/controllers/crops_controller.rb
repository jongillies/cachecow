class CropsController < ApplicationController

  respond_to :html, :json

  def index
    @q = Crop.search(params[:q])
    @total = @q.result(:distinct => true).order("name")
    @crops = @total.paginate(page: params[:page])

    respond_with(@crops)
  end

  def show
    respond_with(@crop = Crop.find(params[:id]))
  end

  def new
    respond_with(@crop = Crop.new)
  end

  def edit
    respond_with(@crop = Crop.find(params[:id]))
  end

  def create
    @crop = Crop.new(params[:crop])
    flash[:notice] = "Crop was successfully created." if @crop.save
    respond_with(@crop)
  end

  def update
    @crop = Crop.find(params[:id])

    if @crop.update_attributes(params[:crop])
      flash[:notice] = "Crop was successfully updated."
    end
    respond_with(@crop)
  end

  def destroy
    @crop = Crop.find(params[:id])
    @crop.destroy
    flash[:notice] = "Crop was successfully destroyed."
    respond_with(@crop)
  end
end
