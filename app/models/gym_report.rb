# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
# 系统管理员Report
#
class GymReport

  include Datagrid

  scope do
    Gym
  end

  filter(:name, :string)
  column(:name)
  column(:status) do
   self.status.text
  end
  column(:created_at, header: I18n.t('views.defaults.label.created_at')) do
    I18n.l(self.created_at.to_date)
  end
  column(:actions, header: I18n.t('views.defaults.label.actions'), :html => true) do |asset|
    render :partial => "admin/master/gym_reports/actions", :locals => {:target => asset}
  end
end

