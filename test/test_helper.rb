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
    assert_redirected_to new_admin_session_url
  end

  # 用来判断是否迁移到了user的登录画面
  def should_redirect_to_user_login
    assert_redirected_to new_user_session_url
  end
end

# 添加了Devise的一些用于测试的helper
class ActionController::TestCase
  include Devise::TestHelpers
end

