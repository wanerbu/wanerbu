class CourtProperty < ActiveRecord::Base
  attr_accessible :court_id, :property_id, :property_value
  belongs_to :court
end
