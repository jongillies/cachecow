class DeliveriesController < ApplicationController

  respond_to :html, :json

  def index
    @q = Delivery.search(params[:q])
    @total = @q.result(:distinct => true).order("created_at DESC")
    @deliveries = @q.result.page(params[:page]).per(5)
    respond_with(@deliveries)
  end

  def show
    respond_with(@delivery = Delivery.find(params[:id]))
  end

  def create
    @delivery = Delivery.new(params[:delivery])
    flash[:notice] = "Delivery log was successfully created." if @delivery.save
    respond_with(@delivery)
  end

end