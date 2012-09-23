class TransactionsController < ApplicationController

  respond_to :html, :json

  def index
    @q = Transaction.search(params[:q])
    @total = @q.result(:distinct => true).order("created_at DESC")
    @transactions = @total.paginate(page: params[:page])
    respond_with(@transactions)
  end

  def show
    respond_with(@transaction = Transaction.find(params[:id]))
  end

  def create

    crop_id = Crop.where(crop_number: params[:crop_number]).limit(1)[0].id
    subscriber_id = Subscription.where(id: params[:subscription_id]).limit(1)[0][:subscriber_id]

    @transaction = Transaction.new(params[:transaction].merge(crop_id: crop_id).merge(subscriber_id: subscriber_id))

    flash[:notice] = "Transaction log was successfully created." if @transaction.save
    respond_with(@transaction)

    #crop_id = Crop.where(crop_number: params[:crop_number]).limit(1)[0].id
    #@transaction = TransactionLog.new(params[:transaction].merge(crop_id: crop_id))
    #flash[:notice] = "Transaction log was successfully created." if @transaction.save
    #respond_with(@transaction)
  end

end