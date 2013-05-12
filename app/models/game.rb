class Game < ActiveRecord::Base
  attr_accessible :court_id, :default_price, :name, :sort
  # validations
  validates :name, 
    :presence => true,
    :length => { :in => 1..50 }
  validates :default_price, 
    :presence => true,
    :numericality => { :greater_than_or_equal_to => 0 }
  validates :sort, 
    :presence => true,
    :numericality => { :only_integer => true,:greater_than => 0 }
end
