# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
#
class Admin::Master::RoleReportsController < Admin::AdminBaseController
  def index
    @role_report = RoleReport.new(params[:role_report])
    @role_report.assets.per_page = 1
    @assets = @role_report.assets.page(params[:page])
  end
end
