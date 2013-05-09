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

  filter(:name, :string)

  column(:name)
  column(:unit)
  column(:intro)
  column(:actions, header: I18n.t('views.defaults.label.actions'), :html => true) do |asset|
    render :partial => "admin/master/property_reports/actions", :locals => {:target => asset}
  end
end
