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
   Court.where("gym_id = ?",User.current.gym.id)
  end
  filter(:sport_id, :string,:header => Sport.model_name.human) do |value|
    self.where(["sport_id = ?", sport_id = (@sport = Sport.where("name LIKE '%#{value}%' ").first) ? @sport.id : ""])
  end

  column(Sport.model_name.human) do
    Sport.find(self.sport_id).name
  end
  column(:reservation_type) do
   self.reservation_type.text
  end
  column(I18n.t('views.defaults.game.game_number')) do
    Game.where(:court_id => self.id).count
  end
  column(:created_at, header: I18n.t('views.defaults.label.created_at')) do
    I18n.l(self.created_at.to_date)
  end
  column(:actions, header: I18n.t('views.defaults.label.actions'), :html => true) do |asset|
    render :partial => "user/master/court_reports/actions", :locals => {:target => asset}
  end
end
