# encoding: UTF-8
#
#--
# FileInfo:
#   Author: dairugang
#++
#
class Admin::AdminBaseController < ApplicationController
  # 需要必须是管理员
  # TODO dairg
  before_filter :authenticate_admin!
  layout 'admin/admin_base'

  ## 定义登录管理员的权限
  def current_ability
    @current_ability ||= AdminAbility.new(current_admin)
  end
  
end
