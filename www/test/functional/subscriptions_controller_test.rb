require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase

  setup do
    @subscription = subscriptions(:one)
  end

  test "subscription#index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscriptions)
  end

  test "subscription#show" do
    get :show, id: @subscription
    assert_response :success
  end

  test "subscription#new" do
    get :new
    assert_response :success
  end

end
