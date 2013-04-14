class Sport < ActiveRecord::Base
  attr_accessible :intro, :name, :sort,:property_ids
  has_many :sport_properties, :dependent => :destroy
  has_many :properties, :through => :sport_properties
end
