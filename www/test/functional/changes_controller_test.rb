require 'test_helper'

class ChangesControllerTest < ActionController::TestCase

  setup do
    @change = changes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:changes)
  end

  test "should show change" do
    get :show, id: @change
    assert_response :success
  end

  #test "should create change" do
  #  assert_difference('Change.count') do
  #    post :create, change: { body: @change }
  #  end
  #
  #  assert_redirected_to change_path(assigns(:change))
  #  assert_not_nil flash[:notice]
  #end


end
