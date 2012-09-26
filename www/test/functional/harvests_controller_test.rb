require 'test_helper'

class HarvestsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  setup do
    @harvest = harvests(:one)
  end

  test "harvest#index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:harvests)
  end

  test "harvest#change" do
    get :show, id: @harvest
    assert_response :success
  end

  test "harvest#create" do
    assert_difference('Harvest.count') do
      post :create, harvest: {
          id: 2,
          crop_number: 400,
          began_at: " 2012-09-23 03:23:16",
          ended_at: "2012-09-23 03:33:16",
          total_records: 2,
          number_of_changes: 0,
          number_of_adds: 2,
          number_of_deletes: 0,
          uuid: "HARVEST0-0000-0000-0000-000000000001"
    }

    end

    assert_redirected_to harvest_path(assigns(:harvest))
    assert_not_nil flash[:notice]

    #puts Harvest.find(2).inspect

  end
end
