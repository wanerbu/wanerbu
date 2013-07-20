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
  skip_authorize_resource :only => [:new,:create,:get_cities_by_province_id,:get_areas_by_city_id] 

  def index
    # TODO Tom 存在性的check
   @gym = current_user.gym
  end

  def new
    #如果该用户已经拥有场馆，将不能再创建
    if Gym.exists?(:user_id => current_user.id)
      flash[:alert] = I18n.t("activemodel.errors.duplicate", model: Gym.model_name.human)
      redirect_to user_master_gyms_path
    end
    @gym = Gym.new
  end

  def create
    @gym = Gym.new(params[:gym])
    @gym.status = 'draft'
    @gym.user_id = current_user.id
    @gym.history_log = generate_log("create") 
    @user_role = UserRole.new
    @user_role.user_id = current_user.id
    #TODO hardcode需要改进
    @user_role.role_id =  Wanerbu::Common::GYM_MANAGER_ROLE_ID
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
    apply_history_log = generate_log("apply")
    if @gym.update_attribute(:status, Wanerbu::CodeDefine::GYM_STATUS[:applying]) && @gym.update_attribute(:history_log, apply_history_log)
      redirect_to user_master_gyms_path, notice: I18n.t("activemodel.success.apply", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.apply", model: Gym.model_name.human)
      render :index
    end
  end
  # 撤销
  def cancel
    @gym = Gym.find(params[:id])
    cancel_history_log = generate_log("cancel")
    if @gym.update_attribute(:status, Wanerbu::CodeDefine::GYM_STATUS[:canceled]) && @gym.update_attribute(:history_log, cancel_history_log)
      redirect_to user_master_gyms_path, notice: I18n.t("activemodel.success.cancel", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.cancel", model: Gym.model_name.human)
      render :index
    end
  end
  # 发布
  def release
    @gym = Gym.find(params[:id])
    release_history_log = generate_log("release")
    if @gym.update_attribute(:status, Wanerbu::CodeDefine::GYM_STATUS[:released]) && @gym.update_attribute(:history_log, release_history_log)
      redirect_to user_master_gyms_path, notice: I18n.t("activemodel.success.release", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.release", model: Gym.model_name.human)
      render :index
    end
  end
  # 暂停发布
  def suspend
    @gym = Gym.find(params[:id])
    suspend_history_log = generate_log("suspend")
    if @gym.update_attribute(:status, Wanerbu::CodeDefine::GYM_STATUS[:suspended]) && @gym.update_attribute(:history_log, suspend_history_log)
      redirect_to user_master_gyms_path, notice: I18n.t("activemodel.success.suspend", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.release", model: Gym.model_name.human)
      render :index
    end
  end
  #upload image
  def upload_image
    @gym_image = GymImage.new(params[:gym_image])
    puts params[:gym_image]
    if @gym_image.save 
      redirect_to user_master_gyms_path, notice: I18n.t("activemodel.success.create", model: GymImage.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.create", model: GymImage.model_name.human)
      render "new"
    end
  end
  def get_cities_by_province_id
    cities = City.where(:province_id=>params[:province_id]) unless params[:province_id].blank?
    render :partial => "cities",:locals => { :cities => cities }
  end
  def get_areas_by_city_id
    areas = Area.where(:city_id=>params[:city_id]) unless params[:city_id].blank?
    render :partial => "areas",:locals => { :areas => areas }
  end
  #生成历史记录
  def generate_log(action)
    if @gym.history_log.nil?
        action_history_log = current_user.login_id + "于"+ Time.now.to_date.to_s + " " + Time.now.strftime("%H:%M").to_s + I18n.t("activemodel.success."+action, model: Gym.model_name.human)  + ";"
    else
        action_history_log = @gym.history_log + current_user.login_id + "于"+ Time.now.to_date.to_s + " " + Time.now.strftime("%H:%M").to_s + I18n.t("activemodel.success."+action, model: Gym.model_name.human)  + ";"
    end
    return action_history_log
  end
end
