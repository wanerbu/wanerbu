class SportAttribute < ActiveRecord::Base
  attr_accessible :attribute_id, :default_value, :required, :scope, :sport_id
end
