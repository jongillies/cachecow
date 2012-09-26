require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  setup do
    @transaction = transactions(:one)
  end

  test "transaction#index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transactions)
  end

  test "transaction#show" do
    get :show, id: @transaction
    assert_response :success
  end

  test "transaction#create" do
    assert_difference('Transaction.count') do
      post :create, transaction: {
          id: 4,
          queue_time: "2012-09-23 03:23:16",
          subscription_id: 1,
          change_uuid: "CHANGE00-0000-0000-1111-000000000001",
          uuid: "TRANS000-0000-0000-2222-000000000001"
      }

    end

    assert_redirected_to transaction_path(assigns(:transaction))
    assert_not_nil flash[:notice]

    #puts Transaction.find(4).inspect

  end


end
