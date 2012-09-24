require 'test_helper'

class CropsControllerTest < ActionController::TestCase

  setup do
    @crop = crops(:one)
  end

  test "should get crop index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:crops)
  end

  test "should show crop" do
    get :show, id: @crop
    assert_response :success
  end

end
