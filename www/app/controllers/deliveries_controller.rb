class DeliveriesController < ApplicationController

  respond_to :html, :json

  def index
    @q = Delivery.search(params[:q])
    @total = @q.result(:distinct => true).order("created_at DESC")
    @deliveries = @total.paginate(page: params[:page])
    respond_with(@deliveries)
  end

  def show
    logger.puts params.inspect

    respond_with(@delivery = Delivery.find(params[:id]))
  end

  def create
    @delivery = Delivery.new(params[:delivery])
    flash[:notice] = "Delivery log was successfully created." if @delivery.save
    respond_with(@delivery)
  end

end