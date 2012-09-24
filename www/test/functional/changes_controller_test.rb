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

  # TODO: Fix me
  #test "should create change" do
  #  assert_difference('Change.count') do
  #    post :create, change: {
  #        id: 3,
  #        crop_number: 400,
  #        queue_time: "2012-09-23 03:34:16",
  #        primary_key: "root",
  #        previous_value: "",
  #        current_value: "root",
  #        transaction_type: "add",
  #        uuid: "CHANGE00-0000-0000-1111-00000000010",
  #        harvester_uuid: "HARVEST0-0000-0000-0000-000000000001"}
  #  end
  #
  #  assert_redirected_to change_path(assigns(:change))
  #  assert_not_nil flash[:notice]
  #
  #  puts Change.find(3).inspect
  #
  #end

end
