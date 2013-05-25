# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
# 属性Report
#
class PropertyReport
  include Datagrid

  scope do
    Property
  end

  filter(:name, :string,:header => "属性名")

  column(:name)
  column(:unit)
  column(:actions, header: I18n.t('views.defaults.label.actions'), :html => true) do |asset|
    render :partial => "admin/master/property_reports/actions", :locals => {:target => asset}
  end
end
