require 'test_helper'

class GymControllerTest < ActionController::TestCase
  test "should get gym_home" do
    get :gym_home
    assert_response :success
  end

end
