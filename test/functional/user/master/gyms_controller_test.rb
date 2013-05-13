require 'test_helper'

class User::Master::GymsControllerTest < ActionController::TestCase
  ### 未登录的情况

  test "should redirect to login when get index" do
    get :index
    should_redirect_to_user_login
  end

  test "should redirect to login when get edit" do
    get :edit, {'id' => "2"}
    should_redirect_to_user_login
  end

  ### 已经登录的情况
  test "should get new when user no gym" do
    sign_in :user, users(:user_unconfirmed_no_gym)

    get :new
    assert_response :success

    sign_out :user
  end
  test "should not get new when user have gym" do
    sign_in :user, users(:user_unconfirmed)

    get :new
    assert_response :redirect

    sign_out :user
  end
  test "should get edit owned gym " do
    sign_in :user, users(:user_unconfirmed)
    get :edit, {'id' => "2"}
    assert_response :success

    sign_out :user
  end
  test "should not get edit if not owned gym " do
    sign_in :user, users(:user_unconfirmed)

    get :edit, {'id' => "1"}
    assert_response 403

    sign_out :user
  end
end
