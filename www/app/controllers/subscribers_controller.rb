class SubscribersController < ApplicationController

  respond_to :html, :json

  def index
    @q = Subscriber.search(params[:q])
    @total = @q.result(:distinct => true).order("name")
    @subscribers = @q.result.page(params[:page]).per(5)
    respond_with(@subscribers)
  end

  def show
    respond_with(@subscriber = Subscriber.find(params[:id]))
  end

  def new
    respond_with(@subscriber = Subscriber.new)
  end

  def edit
    respond_with(@subscriber = Subscriber.find(params[:id]))
  end

  def create
    @subscriber = Subscriber.new(params[:subscriber])
    flash[:notice] = "Subscriber was successfully created." if @subscriber.save
    respond_with(@subscriber)
  end

  def update
    @subscriber = Subscriber.find(params[:id])
    if @subscriber.update_attributes(params[:subscriber])
      flash[:notice] = "Subscriber was successfully updated."
    end
    respond_with(@subscriber)
  end

  def destroy
    @subscriber = Subscriber.find(params[:id])
    @subscriber.destroy
    flash[:notice] = "Subscriber was successfully destroyed."
    respond_with(@subscriber)
  end

end
