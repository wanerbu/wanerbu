module GymHelper
  def show_price(court_id,date)
    @court = Court.find(court_id)
    #calculate price base on court object and date
    def_min_price = @court.games.first.default_price
    def_max_price = @court.games.first.default_price
    min_price = 10 
    max_price = 15

    s = "<em>" + def_min_price.to_s + "-" + def_max_price.to_s + "</em>"+"<b>"+ min_price.to_s + "-" + max_price.to_s + "</b>"
    return s.html_safe

  end
end
