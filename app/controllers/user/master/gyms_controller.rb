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
#TODO 这里的值要根据seesion的user id 得到
    @gym = Gym.find(12)
  end

  def new
    @gym = Gym.new
  end

  def create
    @gym = Gym.new(params[:gym])
    @gym.deleted_at = '10010101'
    @gym.status = '00'
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
    @gym.destroy
    redirect_to user_master_gyms_url
  end
end
