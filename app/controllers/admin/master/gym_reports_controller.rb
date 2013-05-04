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

  def show
    @gym= Gym.find(params[:id])
  end
  # 同意
  def approve
    @gym = Gym.find(params[:id])
    if @gym.update_attribute(:status, Wanerbu::CodeDefine::GYM_STATUS[:approved])
      redirect_to admin_master_gym_report_path(@gym), notice: I18n.t("activemodel.success.approve", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.approve", model: Gym.model_name.human)
      render :index
    end
  end
  # 拒绝
  def reject
    @gym = Gym.find(params[:id])
    if @gym.update_attribute(:status, Wanerbu::CodeDefine::GYM_STATUS[:rejected])
      redirect_to admin_master_gym_report_path(@gym), notice: I18n.t("activemodel.success.reject", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.reject", model: Gym.model_name.human)
      render :index
    end
  end
end
