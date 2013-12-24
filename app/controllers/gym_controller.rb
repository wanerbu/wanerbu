class GymController < ApplicationController
  def gym_home
    sortkey = "case when id in ("
    courts = Court.includes(:games).where("games.can_reservation" => true)
    courts.each do |court|
      sortkey = sortkey + court.gym_id.to_s + ","
    end
    sortkey = sortkey + "0) then 0 else 1 end "
    @gyms = Gym.paginate(:page => params[:page],:per_page => 1).order(sortkey)
    params[:count] = @gyms.count
  end
  def search
    $sql = "1 = 1 "
    if params[:areaid] != "all"then
      $sql = $sql + " and gyms.area_id = " + params[:areaid]
    end  
    if params[:sportid] != "all"then
      $sql = $sql + " and gyms.id in ("
      courts = Court.where(:sport_id => params[:sportid])
      courts.each do |court|
        $sql = $sql + court.gym_id.to_s + ","
      end
      $sql = $sql + "0)"
    end
    if params[:keyword] != "all"then
      $sql = $sql + " and gyms.name LIKE '%#{params[:keyword]}%'"
    end
    if params[:reservekey] != "all"then
      $sql = $sql + " and gyms.id in ("
      courts = Court.includes(:games).where("games.can_reservation" => true)
      courts.each do |court|
        $sql = $sql + court.gym_id.to_s + ","
      end
      $sql = $sql + "0)"
    end
    $sortkey = 'id asc'
    if params[:sortkey] == "opengym" then
      $sortkey = "case when gyms.id in ("
      courts = Court.includes(:games).where("games.can_reservation" => true)
      courts.each do |court|
        $sortkey = $sortkey + court.gym_id.to_s + ","
      end
      $sortkey = $sortkey+ "0) then 0 else 1 end "
      @gyms = Gym.where($sql).paginate(:page => params[:page],:per_page => 1).order($sortkey)
      params[:count] = @gyms.count
    end
    if params[:sortkey] == "score" then
      @gyms = Gym.where($sql).includes(:gym_comments).group("gyms.id").order("avg(gym_comments.score) desc").paginate(:page => params[:page],:per_page => 1)
      params[:count] = Gym.where($sql).count
    end
    render :partial => "gymlist"
  end
  def one_gym
    @gym = Gym.find(params[:id]) 
    @court = Court.where("gym_id = ?",params[:id]).first
    if params[:sportid] != "all"then
      @court = Court.where("sport_id = ? and gym_id = ?",params[:sportid],params[:id]).first
    end
  end
  def submit_comment
    @gym_comment = GymComment.new(params[:gym_comment])
    @gym_comment.save
    @gym = Gym.find(params[:gym_comment][:gym_id])
    render :partial => "gym_comments_list"
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
  def check_order
    rh = {}
    rh[:rs] = []
    params[:reservations].each do |r|
      game = Game.find(r["game_id"])
      s_time = r["start_time"][0..-7].to_time
      e_time = r["end_time"][0..-7].to_time
      if params[:reservation_type] == "according_time"
        if game.has_reservation(s_time,e_time)
          rh[:rs] << r
        end
      else
        remain_people_num = game.get_remain_people_num(s_time)
        if remain_people_num < r[:people_num].to_i
          r[:people_num] = remain_people_num
          rh[:rs] << r
        end
      end
    end
    respond_to do |format|
      format.json { render :json => rh[:rs] }
    end
  end
  def submit_order
    @order = Order.new(params[:order])
    @order.save
    reservations = Reservation.create(params[:reservations])
    reservations.each do |reservation| 
      reservation.order_id = @order.id
      reservation.save
    end
    render "confirm_order"
    t = Thread.new {
      sleep(1.minutes)
      last_order = Order.find(@order.id)
      if last_order.status = "00"
        last_order.status = "92"
        last_order.save
      end
    }
    t.run
  end
  def search_map
    render "transit_search"
  end
  def code_image
    session[:noisy_image] = NoisyImage.new(4)
    session[:code] = session[:noisy_image].code
    image = session[:noisy_image].code_image
    send_data image, :type => 'image/jpeg', :disposition => 'inline'
  end
  def check_code_image
    rs = false;
    puts session[:code]
    if params[:type_code] == session[:code].to_s
      rs = true;
    end
    respond_to do |format|
      format.json { render :json => rs }
    end
  end
end
