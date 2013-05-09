# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
# 项目Report
#
class SportReport
  include Datagrid

  scope do
    Sport
  end

  filter(:name, :string)

  column(:name)
  column(:intro)
  column(:sort)
  column(:actions, header: I18n.t('views.defaults.label.actions'), :html => true) do |asset|
    render :partial => "admin/master/sport_reports/actions", :locals => {:target => asset}
  end
end
