# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class Admin::Master::AttributeReportsController < Admin::AdminBaseController
  def index
    @attribute_report = AttributeReport.new(params[:attribute_report])
    @attribute_report.assets.per_page = 10
    @assets = @attribute_report.assets.page(params[:page])
  end
end
