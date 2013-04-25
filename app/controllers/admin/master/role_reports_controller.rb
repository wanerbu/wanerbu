# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
#
class Admin::Master::RoleReportsController < Admin::AdminBaseController

  # 对于每一个action进行权限检查
  load_and_authorize_resource 

  def index
    @role_report = RoleReport.new(params[:role_report])
    @role_report.assets.per_page = Wanerbu::Common::NUMBER_PER_PAGE
    @assets = @role_report.assets.page(params[:page])
  end
end
