# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
# 系统管理员Report
#
class AdminReport
  include Datagrid

  scope do
    Admin.except_super_admin
  end

  filter(:email, :string)
  filter(:login_id, :string)

  column(:login_id)
  column(:email)
  column(:name)
  column(:created_at)
  column(:actions, :html => true) { |asset| render :partial => "admin/master/admin_reports/actions", :locals => {:target => asset} }
end

