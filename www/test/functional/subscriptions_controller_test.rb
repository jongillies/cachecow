require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

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

  test "subscription#edit" do
    get :edit, id: @subscription
    assert_response :success
  end

  test "subscription#new" do
    get :new
    assert_response :success
  end

  #TODO: Add test for Update
  #TODO: Add test for Create

end
