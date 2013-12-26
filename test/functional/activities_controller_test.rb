require 'test_helper'

class ActivitiesControllerTest < ActionController::TestCase
  test "should get activity_home" do
    get :activity_home
    assert_response :success
  end

end
