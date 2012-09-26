require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase

  test "welcome#index" do
    get :index
    assert_response :success
  end

end
