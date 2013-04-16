class Sport < ActiveRecord::Base
  attr_accessible :intro, :name, :sort,:property_ids, :sport_properties_attributes
  has_many :sport_properties, :dependent => :destroy
  has_many :properties, :through => :sport_properties

  accepts_nested_attributes_for :sport_properties, :allow_destroy => true
end
