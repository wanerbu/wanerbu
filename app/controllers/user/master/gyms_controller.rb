# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class User::Master::GymsController <  User::UserBaseController

  # 对于每一个action进行权限检查,除了新建
  load_and_authorize_resource 
  skip_authorize_resource :only => [:new,:create] 

  def index
    # TODO Tom 存在性的check
   @gym = current_user.gym
  end

  def new
    @gym = Gym.new
  end

  def create
    @gym = Gym.new(params[:gym])
    @gym.status = 'draft'
    @gym.user_id = current_user.id
    @user_role = UserRole.new
    @user_role.user_id = current_user.id
    #TODO hardcode需要改进
    @user_role.role_id = 980190963
    if @gym.save && @user_role.save
      redirect_to user_master_gyms_path, notice: I18n.t("activemodel.success.create", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.create", model: Gym.model_name.human)
      render "new"
    end
  end

  def edit
    @gym = Gym.find(params[:id])
  end

  def update
      @gym = Gym.find(params[:id])
      if @gym.update_attributes(params[:gym])
        redirect_to user_master_gyms_path, notice: I18n.t("activemodel.success.update", model: Gym.model_name.human)
      else
        flash[:alert] = I18n.t("activemodel.errors.update", model: Gym.model_name.human)
        render "edit"
      end
  end

  def destroy
    # TODO Tom 存在性的check
    @gym = Gym.find(params[:id])
    if @gym.destroy
      redirect_to user_root_path, notice: I18n.t("activemodel.success.destroy", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.destroy", model: Gym.model_name.human)
      render :show
    end
  end
  # 申请
  def apply
    @gym = Gym.find(params[:id])
    if @gym.update_attribute(:status, Wanerbu::CodeDefine::GYM_STATUS[:applying])
      redirect_to user_master_gyms_path, notice: I18n.t("activemodel.success.apply", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.apply", model: Gym.model_name.human)
      render :index
    end
  end
  # 撤销
  def cancel
    @gym = Gym.find(params[:id])
    if @gym.update_attribute(:status, Wanerbu::CodeDefine::GYM_STATUS[:canceled])
      redirect_to user_master_gyms_path, notice: I18n.t("activemodel.success.cancel", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.cancel", model: Gym.model_name.human)
      render :index
    end
  end
  # 发布
  def release
    @gym = Gym.find(params[:id])
    if @gym.update_attribute(:status, Wanerbu::CodeDefine::GYM_STATUS[:released])
      redirect_to user_master_gyms_path, notice: I18n.t("activemodel.success.release", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.release", model: Gym.model_name.human)
      render :index
    end
  end
  # 暂停发布
  def suspend
    @gym = Gym.find(params[:id])
    if @gym.update_attribute(:status, Wanerbu::CodeDefine::GYM_STATUS[:suspended])
      redirect_to user_master_gyms_path, notice: I18n.t("activemodel.success.suspend", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.release", model: Gym.model_name.human)
      render :index
    end
  end
end
