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
    @property_report.assets.per_page =  Wanerbu::Common::NUMBER_PER_PAGE 
    @assets = @property_report.assets.page(params[:page])
  end
end
