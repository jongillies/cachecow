class SubscriptionsController < ApplicationController

  respond_to :html, :json

  load_and_authorize_resource unless Rails.env == "test"

  def index
    @q = Subscription.search(params[:q])
    @total = @q.result(:distinct => true)
    @subscriptions =  @q.result.page(params[:page]).per(100)
    respond_with(@subscriptions)
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