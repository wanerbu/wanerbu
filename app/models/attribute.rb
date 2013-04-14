class Attribute < ActiveRecord::Base
  attr_accessible :intro, :name, :unit
  has_many :sport_attributes, :dependent => :destroy
  has_many :sports, :through => :sport_attributes
end
