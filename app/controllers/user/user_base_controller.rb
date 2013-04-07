# encoding: UTF-8
#
#--
# FileInfo:
#   Author: dairugang
#++
#
class User::UserBaseController < ApplicationController
  # 需要必须是登陆用户
  #before_filter :authenticate_user!
  layout 'user/user_base'
end
