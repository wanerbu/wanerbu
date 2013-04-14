# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class Admin::Master::SportReportsController < Admin::AdminBaseController
  def index
    @sport_report = SportReport.new(params[:sport_report])
    @sport_report.assets.per_page = 10
    @assets = @sport_report.assets.page(params[:page])
  end
end
