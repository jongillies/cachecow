class TransactionsController < ApplicationController

  respond_to :html, :json

  def index
    @q = Transaction.search(params[:q])
    @total = @q.result(:distinct => true).order("created_at DESC")
    @transactions =  @q.result.page(params[:page]).per(5)
    respond_with(@transactions)
  end

  def show
    respond_with(@transaction = Transaction.find(params[:id]))
  end

  def create
    @transaction = Transaction.new(params[:transaction])
    flash[:notice] = "transaction log was successfully created." if @transaction.save
    respond_with(@transaction)
  end

end