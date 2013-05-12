# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class Admin::Master::PropertyReportsController < Admin::AdminBaseController
  # 对于每一个action进行权限检查
  load_and_authorize_resource 
  def index
    @property_report = PropertyReport.new(params[:property_report])
    @property_report.assets.per_page =  Wanerbu::Common::NUMBER_PER_PAGE 
    @assets = @property_report.assets.page(params[:page])
  end
end
