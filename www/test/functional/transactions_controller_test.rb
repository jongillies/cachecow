require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase

  setup do
    @transaction = transactions(:one)
  end

  test "should get @transaction index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transactions)
  end

  test "should show transaction" do
    get :show, id: @transaction
    assert_response :success
  end


end
