require 'test_helper'

class SubscribersControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  setup do
    @subscriber = subscribers(:one)
  end

  test "subscriber#index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscribers)
  end

  test "subscriber#show" do
    get :show, id: @subscriber
    assert_response :success
  end

  test "subscriber#edit" do
    get :edit, id: @subscriber
    assert_response :success
  end

  test "subscriber#new" do
    get :new
    assert_response :success
  end

  #TODO: Add test for Update
  #TODO: Add test for Create

end
