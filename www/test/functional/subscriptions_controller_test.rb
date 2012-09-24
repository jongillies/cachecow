require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase

  setup do
    @subscription = subscriptions(:one)
  end

  test "should get subscription index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscriptions)
  end

  test "should show subscription" do
    get :show, id: @subscription
    assert_response :success
  end


end
