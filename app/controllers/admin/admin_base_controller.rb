# encoding: UTF-8
#
#--
# FileInfo:
#   Author: dairugang
#++
#
class Admin::AdminBaseController < ApplicationController
  # 需要必须是管理员
  before_filter :authenticate_admin!
  layout 'admin/admin_base'
end
