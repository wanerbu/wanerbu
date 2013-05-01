# encoding: UTF-8
#
#--
# FileInfo:
#   Author: Tom
#++
#
class User::UserBaseController < ApplicationController
  # 需要必须是登陆用户
  before_filter :authenticate_user!
  layout 'user/user_base'

  ## 权限异常/无权限跳转页定义
  rescue_from CanCan::AccessDenied do |exception|
    render File.join(Rails.root, 'public', '403'), formats: [:html], status: 403, layout: false
  end
  ## 定义登录用户的权限
  def current_ability
    @current_ability ||= UserAbility.new(current_user)
  end
end
