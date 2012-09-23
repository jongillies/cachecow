class DeliveryLogsController < ApplicationController

  respond_to :html, :json

  def index
    @q = DeliveryLog.search(params[:q])
    @total = @q.result(:distinct => true).order("created_at DESC")
    @delivery_logs = @total.paginate(page: params[:page])
    respond_with(@delivery_logs)
  end

  def show
    respond_with(@delivery_log = DeliveryLog.find(params[:id]))
  end

  def create
    @delivery_log = DeliveryLog.new(params[:delivery_log])
    flash[:notice] = "Delivery log was successfully created." if @delivery_log.save
    respond_with(@delivery_log)
  end

end