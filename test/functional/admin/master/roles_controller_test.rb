require 'test_helper'

class Admin::Master::RolesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
