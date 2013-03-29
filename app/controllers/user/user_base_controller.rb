# encoding: UTF-8
#
#--
# FileInfo:
#   Author: dairugang
#++
#
class User::UserBaseController < ApplicationController
  # 需要必须是管理员
  before_filter :authenticate_user!
end
