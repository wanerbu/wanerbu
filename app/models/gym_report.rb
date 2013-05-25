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

  filter(:name, :string,:header => "场馆名")
  column(:name)
  column("user id") do
    User.find(self.user_id).login_id
  end
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

