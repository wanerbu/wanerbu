class Sport < ActiveRecord::Base
  attr_accessible :intro, :name, :sort,:property_ids, :sport_properties_attributes
  has_many :sport_properties, :dependent => :destroy
  has_many :properties, :through => :sport_properties

  # :reject_if 来实现没有选中的属性不会插入一条property_id 为nil 的记录
  accepts_nested_attributes_for :sport_properties, :allow_destroy => true, :reject_if => proc { |attributes| attributes['property_id'].blank? }
  # validations
  validates :name, 
    :presence => true,
    :length => { :in => 1..50 }
  validates :sort, 
    :presence => true,
    :numericality => { :only_integer => true,:greater_than => 0 }
end
