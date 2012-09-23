class SubscriptionsController < ApplicationController

  respond_to :html, :json

  def index
    respond_with(@subscriptions = Subscription.all)
  end

  def show
    respond_with(@subscription = Subscription.find(params[:id]))
  end

  def new
    respond_with(@subscription = Subscription.new)
  end

  def edit
    respond_with(@subscription = Subscription.find(params[:id]))
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    flash[:notice] = "Subscription was successfully created." if @subscription.save
    respond_with(@subscription)
  end

  def update
    @subscription = Subscription.find(params[:id])
    if @subscription.update_attributes(params[:subscription])
      flash[:notice] = "Subscription was successfully updated."
    end
    respond_with(@subscription)
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    flash[:notice] = "Subscription was successfully destroyed."
    respond_with(@subscription)
  end
end