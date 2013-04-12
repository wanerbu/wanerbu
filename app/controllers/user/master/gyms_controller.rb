# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
#
class User::Master::GymsController <  User::UserBaseController
  def index
#TODO 这里的值要根据seesion的user id 得到
    # TODO Tom 存在性的check
   #@gym = User.find(4).gym
   @gym = current_user.gym
  end

  def new
    @gym = Gym.new
  end

  def create
    @gym = Gym.new(params[:gym])
#    @gym.status = '00'
    @gym.status = 'draft'
#TODO 这里的值要根据seesion的user id 得到
#    @gym.user_id = 4
    @gym.user_id = current_user.id
    if @gym.save
       render "index"
    else
       render "new"
    end

  end

  def edit

    @gym = Gym.find(params[:id])

  end

  def update

    @gym = Gym.find(params[:id])

      if @gym.update_attributes(params[:gym])
       render "index"
      else
        render "edit"
      end
  end

  def destroy
    @gym = Gym.find(params[:id])
    # TODO Tom 存在性的check

    if @gym.destroy
      redirect_to user_master_gyms_path, notice: I18n.t("activemodel.success.destroy", model: Gym.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.destroy", model: Gym.model_name.human)
      render :show
    end
  end
end
