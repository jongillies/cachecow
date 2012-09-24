require 'test_helper'

class CropsControllerTest < ActionController::TestCase

  setup do
    @crop = crops(:one)
  end

  test "crop#index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:crops)
  end

  test "crop#show" do
    get :show, id: @crop
    assert_response :success
  end

  test "crop#new" do
    get :new
    assert_response :success
  end

end
