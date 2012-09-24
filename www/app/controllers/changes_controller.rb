class ChangesController < ApplicationController

  respond_to :html, :json

  def index
    @q = Change.search(params[:q])
    @total = @q.result(:distinct => true).order("created_at DESC")
    @changes = @total.paginate(page: params[:page])
    respond_with(@changes)
  end

  def show
    respond_with(@harvest = Change.find(params[:id]))
  end


# Inbound parameters are:
#
# data['harvester_uuid']
# data['crop_number']
# data['queue_time']
# data['primary_key']
# data['previous_value']
# data['current_value']
# data['crop_change_uuid']
# data['transaction_type']

  def create
    @harvest = Change.new(params[:harvest])
    flash[:notice] = "Change was successfully created." if @harvest.save
    respond_with(@harvest)
  end

end