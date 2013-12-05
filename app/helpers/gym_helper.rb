# encoding: UTF-8
#
#--
# FileInfo:
#   Author: 
#++
#
module GymHelper
  #
  #need pass PRM
  #def_min_price
  #def_max_price
  #court_id
  #date
  #
  def show_fix_info(arg,date)
    @court = Court.find(arg["court_id"])
    arg["reservation_type"] = @court.reservation_type 
    fix_min_price = arg["def_min_price"] 
    fix_max_price = arg["def_max_price"]
    fix_reservation = false
    @court.games.all.each do |game|
      arg["game_id"] = game.id
      h = get_fix_price_reservation(arg,date)
      price_array = h.values.flatten!.select { |i| Integer(i) rescue false } 
      reservation_array = h.values.flatten!.select { |i| !(Integer(i) rescue false) } 

      if fix_min_price > price_array.min then
        fix_min_price = price_array.min
      end
      if fix_max_price <  price_array.max then
        fix_max_price = price_array.max
      end
      if reservation_array.include?(true)
        fix_reservation = true
      end
    end
    s = "<b>"+ fix_min_price.to_s + "-" + fix_max_price.to_s + "</b>" + 
      "</span>
         <span class=\"opiInfo_body\">
          <em class=\"q\" title=\"支持票券抵值\">券</em>
          <em class=\"y\" title=\"支持支付优惠\">惠</em>
        </span>
        <span class=\"opiAct\">"
    if fix_reservation
      s = s + "<a href=\"javascript:toOneCourt('#{arg["court_id"]}',#{date})\" target=\"_blank\"><button class=\"btn btn-primary\" type=\"button\">在线预订</button></a>"
    else
      s = s + "<em class=\"c999\">暂不支持预订</em>"
    end
    return s.html_safe
  end
  #
  #need pass PRM
  #open_time
  #close_time
  #min_unit
  #game_id
  #date
  #reservation_type
  #return hash table, key is time, value is fix price, if key is "allday",
  #that means the reservation is according to people 
  #
  def get_fix_price_reservation(arg,date)
    @game = Game.find(arg["game_id"])
    open_time = arg["open_time"]
    close_time = arg["close_time"]
    min_unit = arg["min_unit"]

    fix_price = @game.default_price
    fix_reservation = @game.can_reservation
    h = Hash.new()

    if arg["reservation_type"] == "according_time" then
      (open_time.to_time.utc.to_i .. close_time.to_time.utc.to_i).step(min_unit.hour).each do |time|
        hm = Time.at(time).utc.strftime('%H:%M')
        @game.game_price_rules.where("(week_value = ? and rule_type = '00') or (date_value = ? and rule_type = '01')",date.strftime("%u"),date).order("rule_type asc").all.each do |game_price_rule|
          if (hm >= game_price_rule.start_time.to_time.utc.strftime('%H:%M')) && (hm <= game_price_rule.end_time.to_time.utc.strftime('%H:%M') ) 
            fix_price = game_price_rule.price
          end
        end
        @game.game_reservation_rules.where("(week_value = ? and rule_type = '00') or (date_value = ? and rule_type = '01')",date.strftime("%u"),date).order("rule_type asc").all.each do |game_reservation_rule|
          if (hm >= game_reservation_rule.start_time.to_time.utc.strftime('%H:%M')) && (hm <= game_reservation_rule.end_time.to_time.utc.strftime('%H:%M') ) 
            fix_reservation = game_reservation_rule.can_reservation
          end
        end
        h[hm] = [fix_price,fix_reservation]
        fix_price = @game.default_price
        fix_reservation = @game.can_reservation
      end
    end
    if arg["reservation_type"] == "according_people" then
      @game.game_price_rules.where("(week_value = ? and rule_type = '00') or (date_value = ? and rule_type = '01')",date.strftime("%u"),date).order("rule_type asc").all.each do |game_price_rule|
        fix_price = game_price_rule.price
      end
      @game.game_reservation_rules.where("(week_value = ? and rule_type = '00') or (date_value = ? and rule_type = '01')",date.strftime("%u"),date).order("rule_type asc").all.each do |game_reservation_rule|
        fix_reservation = game_reservation_rule.can_reservation
      end
      h["allday"] = [fix_price,fix_reservation]
    end
    return h
  end

  def show_week(date)
    case date.strftime("%w")
    when "0"
      s = "周日"
    when "1"
      s = "周一"
    when "2"
      s = "周二"
    when "3"
      s = "周三"
    when "4"
      s = "周四"
    when "5"
      s = "周五"
    when "6"
      s = "周六"
    end
    return s
  end
end
