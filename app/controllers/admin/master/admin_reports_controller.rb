# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
#
class Admin::Master::AdminReportsController < Admin::AdminBaseController

  # 对于每一个action进行权限检查
  load_and_authorize_resource 

  def index
    @admin_report = AdminReport.new(params[:admin_report])
    @admin_report.assets.per_page = Wanerbu::Common::NUMBER_PER_PAGE
    @assets = @admin_report.assets.page(params[:page])
  end
end
