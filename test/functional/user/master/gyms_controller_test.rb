require 'test_helper'

class User::Master::GymsControllerTest < ActionController::TestCase
  ### 未登录的情况

  test "should redirect to login when get index" do
    get :index
    should_redirect_to_user_login
  end

end
