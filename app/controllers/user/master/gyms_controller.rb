
class User::Master::GymsController < ApplicationController
  
  def index

    @gyms = Gym.all
  end
  
  def show
    @gym = Gym.find(params[:id])
  end

  def new
    @gym = Gym.new
  end

  def create
    @gym = Gym.new(params[:gym])
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

    respond_to do |format|
      if @gym.update_attributes(params[:gym])
#页面不不能刷新
        redirect_to user_master_gym_url(@gym)
#         render "show" 
      else
        render "edit"
      end
    end

  end

  def destroy
    @gym = Gym.find(params[:id])
    @gym.destroy
    redirect_to user_master_gyms_url
  end


end
