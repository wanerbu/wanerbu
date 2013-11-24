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
    if params[:keyword] != "all"then
      $sql = $sql + " and name LIKE '%#{params[:keyword]}%'"
    end
    if params[:reservekey] != "all"then
      $sql = $sql + " and id in ("
      courts = Court.includes(:games).where("games.can_reservation" => true)
      courts.each do |court|
        $sql = $sql + court.gym_id.to_s + ","
      end
      $sql = $sql + "0)"
    end
    $sortkey = 'id asc'
    if params[:sortkey] == "score" then
       $sortkey = 'score asc'
    end
    @gyms = Gym.where($sql).paginate(:page => params[:page],:per_page => 1).order($sortkey)
    render :partial => "gymlist"
  end
end
