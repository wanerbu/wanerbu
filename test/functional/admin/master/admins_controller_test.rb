require 'test_helper'

class Admin::Master::AdminsControllerTest < ActionController::TestCase

  ### 未登录的情况

  test "should redirect to login when get new" do
    get :new
    should_redirect_to_admin_login
  end

  test "should redirect to login when get edit" do
    get :edit, {'id' => "2"}
    should_redirect_to_admin_login
  end

  ### 已经登录的情况
  test "should get new" do
    sign_in :admin, admins(:only_super_admin)

    get :new
    assert_response :success

    sign_out :admin
  end

end
