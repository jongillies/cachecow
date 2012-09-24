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
    @change = Change.new(params[:change])
    flash[:notice] = "Change was successfully created." if @change.save
    respond_with(@change)
  end

end