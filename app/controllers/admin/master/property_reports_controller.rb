# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class Admin::Master::PropertyReportsController < Admin::AdminBaseController
  def index
    @property_report = PropertyReport.new(params[:property_report])
    @property_report.assets.per_page = 10
    @assets = @property_report.assets.page(params[:page])
  end
end
