class SportProperty < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :property_id, :default_value, :required, :scope, :sport_id
  belongs_to :sport
  belongs_to :property
end
