class Sport < ActiveRecord::Base
  attr_accessible :intro, :name, :sort,:attribute_ids
  has_many :sport_attributes, :dependent => :destroy
  has_many :attributes, :through => :sport_attributes
end
