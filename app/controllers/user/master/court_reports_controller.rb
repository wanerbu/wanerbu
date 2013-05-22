# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class User::Master::CourtReportsController < User::UserBaseController
  # 对于每一个action进行权限检查
  load_and_authorize_resource 
  before_filter :set_current_user
  def index
    @court_report = CourtReport.new(params[:court_report])
    @court_report.assets.per_page =  Wanerbu::Common::NUMBER_PER_PAGE
    @assets = @court_report.assets.page(params[:page])
  end
end
