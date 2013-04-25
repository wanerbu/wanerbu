# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
# 角色Report
#
class RoleReport
  include Datagrid

  scope do
    Role
  end

  filter(:name, :string)

  column(:name)
  column(:actions, :html => true) { |asset| render :partial => "admin/master/role_reports/actions", :locals => {:target => asset} }
end

