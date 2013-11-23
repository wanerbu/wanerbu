class GymController < ApplicationController
  def gym_home
    @gyms = Gym.paginate(:page => params[:page],:per_page => 1).order('id asc')
  end
  def search
   $sql = "1 = 1 "
   if params[:areaid] != "all"then
    $sql = $sql + " and area_id = " + params[:areaid]
   end  
   if params[:sportid] != "all"then
    $sql = $sql + " and id in ("
    courts = Court.where(:sport_id => params[:sportid])
    courts.each do |court|
      $sql = $sql + court.gym_id.to_s + ","
    end
    $sql = $sql + "0)"
   end  
    @gyms = Gym.where($sql).paginate(:page => params[:page],:per_page => 1).order('id asc')
    render :partial => "gymlist"
  end
end
