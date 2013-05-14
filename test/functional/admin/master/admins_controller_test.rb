# encoding: UTF-8
require 'test_helper'

class Admin::Master::AdminsControllerTest < ActionController::TestCase

  # called before every single test
  def setup
    sign_in :admin, admins(:only_super_admin)
  end

  # called after every single test
  def teardown
    sign_out :admin
  end
  
  ### 未登录的情况

  test "should redirect to login when get new" do
    sign_out :admin

    get :new
    should_redirect_to_admin_login
  end

  test "should redirect to login when get edit" do
    sign_out :admin

    get :edit, {'id' => "2"}
    should_redirect_to_admin_login
  end

  ### 已经登录的情况
  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:admin)
    assert_equal Admin.new.to_yaml, assigns(:admin).to_yaml
  end

  test "should get show" do
    get :show, {id: 3}
    assert_response :success
    assert_not_nil assigns(:admin)
    assert_equal admins(:admin_operator).to_yaml, assigns(:admin).to_yaml
  end

  test "should get edit" do
    get :edit, {id: 3}
    assert_response :success
    assert_not_nil assigns(:admin)
    assert_equal admins(:admin_operator).to_yaml, assigns(:admin).to_yaml
  end

  test "should create admin successfully" do
    tmpadmin = { 
      login_id: "tmpadmin01",
      email: "tmpadmin01@wanerbu.com",
      password: "tmpadmin01" 
    }

    assert_difference("Admin.count", 1) do
      post :create, :admin => tmpadmin
    end
    created_admin = assigns(:admin)
    assert_not_nil created_admin
    assert_not_nil created_admin.id
    assert_equal tmpadmin[:login_id], created_admin.login_id
    assert_equal tmpadmin[:email], created_admin.email
    assert_equal I18n.t("activemodel.success.create", model: Admin.model_name.human), flash[:notice]
    assert_redirected_to admin_master_admin_path(assigns[:admin])
  end

  test "should create admin failure when validate error" do
    tmpadmin = { 
      email: "tmpadmin01@wanerbu.com",
      password: "tmpadmin01" 
    }

    assert_no_difference("Admin.count") do
      post :create, :admin => tmpadmin
    end
    created_admin = assigns(:admin)
    assert_not_nil created_admin
    assert_nil created_admin.id
    assert_equal tmpadmin[:login_id], created_admin.login_id
    wanerbu_assert_alert_msg( I18n.t("activemodel.errors.create", model: Admin.model_name.human) )
    assert_equal I18n.t('errors.messages.blank'), created_admin.errors[:login_id][0]
    assert_template :new
  end

  test "should update admin successfully" do
    assert_equal "普通管理员", Admin.find(4).first_name
    tmpadmin = { first_name: '修改'}
    assert_no_difference("Admin.count") do
      put :update, id: 4, :admin => tmpadmin
    end
    updated_admin = assigns(:admin)
    assert_not_nil updated_admin
    assert_equal "修改", updated_admin.first_name
    assert_equal I18n.t("activemodel.success.update", model: Admin.model_name.human), flash[:notice]
    assert_redirected_to admin_master_admin_path(updated_admin)
  end

  test "should update admin failure when validate error" do
    assert_equal "普通管理员", Admin.find(4).first_name
    tmpadmin = { first_name: '12345678901'}
    assert_no_difference("Admin.count") do
      put :update, id: 4, :admin => tmpadmin
    end
    updated_admin = assigns(:admin)
    assert_not_nil updated_admin
    assert_equal "12345678901", updated_admin.first_name
    wanerbu_assert_alert_msg( I18n.t("activemodel.errors.update", model: Admin.model_name.human) )
    assert_equal I18n.t('errors.messages.too_long', {count: 10}), updated_admin.errors[:first_name][0]
    assert_template :edit
  end

  test "should locked admin" do
    post :lock, id: 4

    assert_not_nil assigns[:admin].status
    assert assigns[:admin].status.locked?
    assert_equal I18n.t("activemodel.success.lock", model: Admin.model_name.human), flash[:notice]

    assert_redirected_to admin_master_admin_path(assigns[:admin])
  end

  test "should not lock the only super admin" do
    post :lock, id: Admin::SUPER_ADMIN_ID

    assert_not_nil assigns[:admin]
    assert_not_nil assigns[:admin].status
    assert !assigns[:admin].status.locked?
    # TODO dairg 403 test
  end

  test "should destroy admin" do
    assert_difference("Admin.count", -1) do
      delete :destroy, id: 4
    end

    assert_not_nil Admin.unscoped.find(4).deleted_at
    assert_equal I18n.t("activemodel.success.destroy", model: Admin.model_name.human), flash[:notice]

    assert_redirected_to admin_master_admin_reports_path
  end

  test "should not destroy the only super admin" do
    assert_no_difference("Admin.count") do
      delete :destroy, id: Admin::SUPER_ADMIN_ID
    end

    assert_nil Admin.unscoped.find(Admin::SUPER_ADMIN_ID).deleted_at
  end

end
