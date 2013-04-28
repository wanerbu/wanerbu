class Game < ActiveRecord::Base
  attr_accessible :court_id, :default_price, :name, :sort
end
