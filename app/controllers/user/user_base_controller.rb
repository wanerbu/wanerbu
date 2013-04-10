# encoding: UTF-8
#
#--
# FileInfo:
#   Author: Tom
#++
#
class User::UserBaseController < ApplicationController
  # 需要必须是登陆用户
  #before_filter :authenticate_user!
  layout 'user/user_base'
  # TODO Tom
  # save user_id into session
  #private
  #  Finds the User with the ID stored in the session with the key
  # :current_user_id This is a common way to handle user login in
  # a Rails application; logging in sets the session value and
  #  logging out removes it.
  #  def current_user
  #       @_current_user ||= session[:current_user_id] &&
  #        User.find_by_id(session[:current_user_id])
  #  end
end
