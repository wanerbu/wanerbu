# encoding: UTF-8
#--
# FileInfo:
#   Author: Tom
#
#++
#
class User::Master::CourtsController <  User::UserBaseController
  def show
    @court = Court.find(params[:id])
  end

  def new
    @court = Court.new
  end

  def create

    #如果该场馆已经拥有该项目，将不能再创建
    if  @court = Court.where(:gym_id => current_user.gym.id,:sport_id => params[:court][:sport_id]).first 
      flash[:alert] = I18n.t("activemodel.errors.duplicate", model: Court.model_name.human)
      redirect_to user_master_court_path(@court)
    else

    @court = Court.new(params[:court])
    game_number = params[:game_number].to_i
    game_default_price = params[:game_default_price].to_i
    @court.gym_id = current_user.gym.id
    if @court.save
      #根据场次数批量添加场次
      game_number.times {|i| Game.create(:court_id=> @court.id, :default_price => game_default_price,:name => "场次" + (i+1).to_s,:sort => (i+1)) }
      redirect_to user_master_court_path(@court), notice: I18n.t("activemodel.success.create", model: Court.model_name.human)
    else
      flash[:alert] = I18n.t("activemodel.errors.create", model: Court.model_name.human)
      render :new
    end
    end
  end

  def edit_court_properties_select
    sport_properties = SportProperty.where(:sport_id=>params[:id]) unless params[:id].blank?
    render :partial => "properties",:locals => { :sport_properties => sport_properties }
  end

  def edit
    @court = Court.find(params[:id])
  end

  def update
    @court = Court.find(params[:id])
    game_number = params[:game_number].to_i
    game_default_price = params[:game_default_price].to_i
      if @court.update_attributes(params[:court])
         #取出当前DB中的场次数量 
         current_game_count = Game.where(:court_id => @court.id).count
         if current_game_count > game_number then
         #destroy
            destroy_number = current_game_count - game_number 
            destroy_number.times{Game.where(:court_id => @court.id).last.destroy}
         elsif current_game_count < game_number then
         #add
            add_number = game_number - current_game_count
            add_number.times {|i| Game.create(:court_id=> @court.id, :default_price => game_default_price,:name => "场次" + (current_game_count+i+1).to_s,:sort => (current_game_count+i+1)) }
         else
           Game.where(:court_id => @court.id).each do |game|
            game.update_attributes(:default_price => game_default_price)
           end
         end
      redirect_to user_master_court_path(@court), notice: I18n.t("activemodel.success.update", model: Court.model_name.human)
      else
        render "edit"
      end
  end

  def destroy
    # TODO Tom 存在性的check
    @court = Court.find(params[:id])
    if @court.destroy
        render "new"
    else
      flash[:alert] = I18n.t("activemodel.errors.destroy", model: Court.model_name.human)
      render :show
    end
  end

end
