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
  test "should not get index if user no gym" do
    sign_in :user, users(:user_unconfirmed_no_gym)
    get :index
    assert_response 403
  end
  test "should get index if user have gym" do
    sign_in :user, users(:user_unconfirmed)
    get :index
    assert_response :success
  end
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
  test "should not get edit owned bym but not gymer " do
    sign_in :user, users(:user_not_gymer)

    get :edit, {'id' => "4"}
    assert_response 403

    sign_out :user
  end
  test "should create gym successfully when user no gym" do
    sign_in :user, users(:user_unconfirmed_no_gym)
    tmp_gym = { 
      name: "tmp gym",
      intro: "tmp gym intro",
      address: "tmp gym address",
      telephone: 222222222,
      open_time: Time.now,
      close_time: Time.now,
      user_id:  3
    }
    assert_difference("Gym.count", 1) do
      post :create, :gym => tmp_gym
    end
    created_gym = assigns(:gym)
    assert_not_nil created_gym
    assert_not_nil created_gym.id
    assert_equal tmp_gym[:name], created_gym.name
    assert_equal tmp_gym[:intro], created_gym.intro
    assert_equal I18n.t("activemodel.success.create", model: Gym.model_name.human), flash[:notice]
    assert_redirected_to user_master_gym_path(assigns[:gym])
  end

end
