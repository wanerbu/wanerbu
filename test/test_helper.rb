ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  # 用来判断是否迁移到了admin的登录画面
  def should_redirect_to_admin_login
    assert_equal I18n.t("devise.failure.unauthenticated"), flash[:alert]
    assert_redirected_to new_admin_session_url
  end

  # 用来判断是否迁移到了user的登录画面
  def should_redirect_to_user_login
    assert_equal I18n.t("devise.failure.unauthenticated"), flash[:alert]
    assert_redirected_to new_user_session_url
  end

  # 用来判断flash[:alert]中的内容(主要是针对那些出错后没有redirect，而是render的action)
  # 原因是在view中一旦显示了msg，就会把flash清空，而如果没有重定向的话，那么发送请求后，
  # 会在这个render执行后，也就是清空flash后才会在测试用例中进行断言的判断，这个时候，
  # flash已经被清空。所以要在view的级别进行测试。
  def wanerbu_assert_alert_msg(expected_msg=nil)
    assert_select 'div.alert-error', expected_msg
  end
end

# 添加了Devise的一些用于测试的helper
class ActionController::TestCase
  include Devise::TestHelpers
end

