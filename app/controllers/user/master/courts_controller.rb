# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class User::Master::CourtsController <  User::UserBaseController
  # 对于每一个action进行权限检查
  load_and_authorize_resource 
  skip_authorize_resource :only => [:new,:create,:edit_court_properties_select] 
  def show
    @court = Court.find(params[:id])
  end

  def new
    @court = Court.new
  end

  def create
    #如果该场馆已经拥有该项目，将不能再创建
    reservation_type = "00"
    case params[:court][:reservation_type]
        when "according_time"
          reservation_type = Wanerbu::CodeDefine::COURT_RESERVATION_TYPE[:according_time]
        when "according_people"
          reservation_type = Wanerbu::CodeDefine::COURT_RESERVATION_TYPE[:according_people]
    end
    if  @court = Court.where(:gym_id => current_user.gym.id,:sport_id => params[:court][:sport_id],:reservation_type => reservation_type).first 
      flash[:alert] = I18n.t("activemodel.errors.duplicate", model: Court.model_name.human)
      redirect_to user_master_court_path(@court)
    else
      @court = Court.new(params[:court])
      game_number = params[:game_number].to_i
      game_default_price = params[:game_default_price].to_i
      can_reservation = params[:can_reservation_in_court] 
      @court.gym_id = current_user.gym.id
      if @court.save
        #根据场次数批量添加场次
        game_number.times {|i| Game.create(:court_id=> @court.id, :default_price => game_default_price,:can_reservation =>can_reservation, :name => "场次" + (i+1).to_s,:sort => (i+1)) }
        redirect_to user_master_court_path(@court), notice: I18n.t("activemodel.success.create", model: Court.model_name.human)
      else
        flash[:alert] = I18n.t("activemodel.errors.create", model: Court.model_name.human)
        render "new"
      end
    end
  end

  def edit_court_properties_select
    sport_properties = SportProperty.where(:sport_id=>params[:sport_id]) unless params[:sport_id].blank?
    render :partial => "properties",:locals => { :sport_properties => sport_properties }
  end

  def edit
    @court = Court.find(params[:id])
  end

  def update
    @court = Court.find(params[:id])
=begin
更新场地是批量更新场次逻辑取消
    game_number = params[:game_number].to_i
    game_default_price = params[:game_default_price].to_i
    can_reservation =  params[:can_reservation_in_court] 
=end
      if @court.update_attributes(params[:court])
=begin
更新场地是批量更新场次逻辑取消
         #取出当前DB中的场次数量 
         current_game_count = Game.where(:court_id => @court.id).count
         if current_game_count > game_number then
         #destroy
            destroy_number = current_game_count - game_number 
            destroy_number.times{Game.where(:court_id => @court.id).last.destroy}
         elsif current_game_count < game_number then
         #add
            add_number = game_number - current_game_count
            add_number.times {|i| Game.create(:court_id=> @court.id, :default_price => game_default_price,:can_reservation => can_reservation,:name => "场次" + (current_game_count+i+1).to_s,:sort => (current_game_count+i+1)) }
         else
           Game.where(:court_id => @court.id).each do |game|
            game.update_attributes(:default_price => game_default_price,:can_reservation => can_reservation)
           end
         end
=end
      redirect_to user_master_court_path(@court), notice: I18n.t("activemodel.success.update", model: Court.model_name.human)
      else
        render "edit"
      end
  end

  def destroy
    # TODO Tom 存在性的check
    @court = Court.find(params[:id])
    if @court.destroy
        redirect_to :action => "new"
    else
      flash[:alert] = I18n.t("activemodel.errors.destroy", model: Court.model_name.human)
      render :show
    end
  end

end
