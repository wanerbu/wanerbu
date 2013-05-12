# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
# 场地Report
#
class GameReport
  include Datagrid

  scope do
    Game
  end
#TODO 这里需要按项目名查找
  filter(:name, :string)

  column("项目") do
    Sport.find(Court.find(self.court_id).sport_id).name
  end
  column(:name)
  column(:default_price)
  column(:actions, header: I18n.t('views.defaults.label.actions'), :html => true) do |asset|
    render :partial => "user/master/game_reports/actions", :locals => {:target => asset}
  end
end
