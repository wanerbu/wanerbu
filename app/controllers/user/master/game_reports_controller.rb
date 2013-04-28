# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class User::Master::GameReportsController < User::UserBaseController
  def index
    @game_report = GameReport.new(params[:game_report])
    @game_report.assets.per_page =  Wanerbu::Common::NUMBER_PER_PAGE
    @assets = @game_report.assets.page(params[:page])
  end
end
