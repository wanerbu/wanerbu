# encoding: UTF-8
#
#--
# FileInfo:
#   Author: dairugang
#++
#
class Admin::Admins::SessionsController < Devise::SessionsController
  # TODO dairg 修改layout
  # layout 'admin/admin_base'
  layout false
end
