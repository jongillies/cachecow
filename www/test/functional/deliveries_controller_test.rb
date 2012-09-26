require 'test_helper'

class DeliveriesControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  setup do
    @delivery = deliveries(:one)
  end

  test "delivery#index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deliveries)
  end

  test "delivery#show" do
    get :show, id: @delivery
    assert_response :success
  end

  test "delivery#create" do
    assert_difference('Delivery.count') do
      post :create, delivery: {
          id: 4,
          queue_time: "2012-09-23 03:34:16",
          uuid: "DELIVERY-0000-0000-3333-000000000004",
          transaction_uuid: "TRANS000-0000-0000-2222-000000000001",
          endpoint_response_code: 200,
          endpoint_response_header: "endpoint_response_header",
          endpoint_response_data: "endpoint_response_data",
          endpoint_response_date: "2012-09-23 03:34:16"
      }

    end

    assert_redirected_to delivery_path(assigns(:delivery))
    assert_not_nil flash[:notice]

    #puts Delivery.find(4).inspect

  end


end
