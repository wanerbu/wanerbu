# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class User::Master::GameReportsController < User::UserBaseController
  # 对于每一个action进行权限检查
  load_and_authorize_resource 
  before_filter :set_current_user
  def index
    @game_report = GameReport.new(params[:game_report])
    @game_report.assets.per_page =  Wanerbu::Common::NUMBER_PER_PAGE
    @assets = @game_report.assets.page(params[:page])
  end
end
