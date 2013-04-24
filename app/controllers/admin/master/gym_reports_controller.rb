# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class Admin::Master::GymReportsController < Admin::AdminBaseController
  def index
    @gym_report = GymReport.new(params[:gym_report])
    @gym_report.assets.per_page =  Wanerbu::Common::NUMBER_PER_PAGE
    @assets = @gym_report.assets.page(params[:page])
  end
end
