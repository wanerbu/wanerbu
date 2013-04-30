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
  column(:actions, header: I18n.t('views.defaults.label.actions'), :html => true) do |asset|
    render :partial => "admin/master/role_reports/actions", :locals => {:target => asset}
  end
end

