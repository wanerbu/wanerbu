class GymController < ApplicationController
  def gym_home
    @gyms = Gym.paginate(:page => params[:page],:per_page => 1).order('id asc')
  end
  def search
    @gyms = Gym.where(:area_id => params[:areaid]).paginate(:page => params[:page],:per_page => 1).order('id asc')
    render :partial => "gymlist"
  end
end
