# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
#
class Admin::Master::AdminReportsController < Admin::AdminBaseController
  def index
    @admin_report = AdminReport.new(params[:admin_report])
    @admin_report.assets.per_page = 1
    @assets = @admin_report.assets.page(params[:page])
  end
end
