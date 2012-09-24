require 'test_helper'

class SubscribersControllerTest < ActionController::TestCase

  setup do
    @subscriber = subscribers(:one)
  end

  test "should get subscriber index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subscribers)
  end

  test "should show subscriber" do
    get :show, id: @subscriber
    assert_response :success
  end

end
