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
    Game.where(:court_id => User.current.gym.court_ids).order("games.court_id asc")
  end

  #TODO select的名字显示需要调查，暂时用下面的模糊查询
  #filter(:court_id, :enum, :select => ["980190968", "2"],:header => "项目") 

  filter(:court_id, :string,:header => "项目") do |value|
    self.where(["court_id = ?", court_id = (@court = Court.where(:sport_id => sport_id = (@sport = Sport.where("name LIKE '%#{value}%' ").first) ? @sport.id : "").first) ? @court.id : ""])
  end

  column("项目") do
    Sport.find(Court.find(self.court_id).sport_id).name
  end
  column("预订类型") do
    Court.find(self.court_id).reservation_type.text
  end
  column(:name)
  column(:default_price)
  column(:can_reservation) do
    if self.can_reservation
      "可以预订"
    else
      "不可以预订"
    end
  end
  column(:sort)
  column(:actions, header: I18n.t('views.defaults.label.actions'), :html => true) do |asset|
    render :partial => "user/master/game_reports/actions", :locals => {:target => asset}
  end
end
