# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class Admin::Master::SportReportsController < Admin::AdminBaseController
  # 对于每一个action进行权限检查
  load_and_authorize_resource 
  def index
    @sport_report = SportReport.new(params[:sport_report])
    @sport_report.assets.per_page =  Wanerbu::Common::NUMBER_PER_PAGE
    @assets = @sport_report.assets.page(params[:page])
  end
end
