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
    approve_history_log = generate_log("approve")
    if @gym.update_attribute(:status, Wanerbu::CodeDefine::GYM_STATUS[:approved]) && @gym.update_attribute(:history_log, approve_history_log)
      redirect_to admin_master_gym_report_path(@gym), notice: I18n.t("activemodel.success.approve", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.approve", model: Gym.model_name.human)
      render :index
    end
  end
  # 拒绝
  def reject
    @gym = Gym.find(params[:id])
    reject_history_log = generate_log("approve")
    if @gym.update_attribute(:status, Wanerbu::CodeDefine::GYM_STATUS[:rejected]) && @gym.update_attribute(:history_log, reject_history_log)
      redirect_to admin_master_gym_report_path(@gym), notice: I18n.t("activemodel.success.reject", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.reject", model: Gym.model_name.human)
      render :index
    end
  end
  #生成历史记录
  def generate_log(action)
    if @gym.history_log.nil?
        action_history_log = current_admin.login_id + "于"+ Time.now.to_date.to_s + " " + Time.now.strftime("%H:%M").to_s + I18n.t("activemodel.success."+action, model: Gym.model_name.human)  + ";"
    else
        action_history_log = @gym.history_log + current_admin.login_id + "于"+ Time.now.to_date.to_s + " " + Time.now.strftime("%H:%M").to_s + I18n.t("activemodel.success."+action, model: Gym.model_name.human)  + ";"
    end
    return action_history_log
  end
end
