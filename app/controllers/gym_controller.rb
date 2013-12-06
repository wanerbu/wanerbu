class GymController < ApplicationController
  def gym_home
    sortkey = "case when id in ("
    courts = Court.includes(:games).where("games.can_reservation" => true)
    courts.each do |court|
      sortkey = sortkey + court.gym_id.to_s + ","
    end
    sortkey = sortkey + "0) then 0 else 1 end "
    @gyms = Gym.paginate(:page => params[:page],:per_page => 1).order(sortkey)
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
      $sortkey = 'score desc'
    end
    if params[:sortkey] == "opengym" then
      $sortkey = "case when id in ("
      courts = Court.includes(:games).where("games.can_reservation" => true)
      courts.each do |court|
        $sortkey = $sortkey + court.gym_id.to_s + ","
      end
      $sortkey = $sortkey+ "0) then 0 else 1 end "
    end
    @gyms = Gym.where($sql).paginate(:page => params[:page],:per_page => 1).order($sortkey)
    render :partial => "gymlist"
  end
  def one_gym
    @gym = Gym.find(params[:id]) 
    @court = Court.where("gym_id = ?",params[:id]).first
    if params[:sportid] != "all"then
      @court = Court.where("sport_id = ? and gym_id = ?",params[:sportid],params[:id]).first
    end
  end
  def getcourt
    @gym = Gym.find(params[:gymid])
    reservation_type = "00"
    case params[:reservationtype]
        when "according_time"
          reservation_type = Wanerbu::CodeDefine::COURT_RESERVATION_TYPE[:according_time]
        when "according_people"
          reservation_type = Wanerbu::CodeDefine::COURT_RESERVATION_TYPE[:according_people]
    end
    @court = Court.where(:gym_id => params[:gymid],:sport_id => params[:sportid],:reservation_type => reservation_type).first 
    if @court == nil then
    @court = Court.where(:gym_id => params[:gymid],:sport_id => params[:sportid]).first 
    end
    render :partial => "reservelist"
  end
  def reserve
    @court = Court.find(params[:id]) 
  end
  def searchgame
    @court = Court.find(params[:id]) 
    render :partial => "gamelist"
  end
end
