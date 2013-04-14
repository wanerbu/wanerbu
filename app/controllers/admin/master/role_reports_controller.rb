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
    @role_report.assets.per_page = Wanerbu::Common::NUMBER_PER_PAGE
    @assets = @role_report.assets.page(params[:page])
  end
end
