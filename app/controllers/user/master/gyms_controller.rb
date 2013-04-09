# encoding: UTF-8
#--
# FileInfo:
#   Author: dairugang
#
#++
#
class User::Master::GymsController <  User::UserBaseController
  def show
    @gym = Gym.find(params[:id])
  end
  def index
  end

  def new
    @gym = Gym.new
  end

  def create
    @gym = Gym.new(params[:gym])
    @gym.deleted_at = '10010101'
    @gym.status = '00'
    if @gym.save
       render "show", notice: 'Gym was successfully created.'
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
#页面不不能刷新
        redirect_to user_master_gym_url(@gym)
#         render "show" 
      else
        render "edit"
      end
  end

  def destroy
    @gym = Gym.find(params[:id])
    @gym.destroy
    redirect_to user_master_gyms_url
  end
end
