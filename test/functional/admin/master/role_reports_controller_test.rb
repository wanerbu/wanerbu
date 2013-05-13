require 'test_helper'

class Admin::Master::RoleReportsControllerTest < ActionController::TestCase

  ### 未登录的情况

  test "should redirect to login when get index" do
    get :index
    should_redirect_to_admin_login
  end

end
