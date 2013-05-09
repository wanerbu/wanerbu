class Property < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :intro, :name, :unit
  has_many :sport_properties, :dependent => :destroy
  has_many :sports, :through => :sport_properties
  # validations
  validates :name, 
    :presence => true,
    :length => { :in => 1..20 }
end
