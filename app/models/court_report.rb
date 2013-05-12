# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
# 场地Report
#
class CourtReport
  include Datagrid

  scope do
    Court
  end
#TODO 这里需要按项目名查找
  filter(:id, :string)

  column("项目") do
    Sport.find(self.sport_id).name
  end
  column("场次数量") do
    Game.where(:court_id => self.id).count
  end
  column(:created_at, header: I18n.t('views.defaults.label.created_at')) do
    I18n.l(self.created_at.to_date)
  end
  column(:actions, header: I18n.t('views.defaults.label.actions'), :html => true) do |asset|
    render :partial => "user/master/court_reports/actions", :locals => {:target => asset}
  end
end
