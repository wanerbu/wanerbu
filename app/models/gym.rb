class Gym < ActiveRecord::Base
  # attr_accessible :title, :body
 attr_accessible :name,:intro,:address,:telephone,:open_time,:close_time,:score,:status,:deleted_at

  validates :telephone, :length => { :in => 0..15 }
  validates :telephone, :format => { if: "telephone.present?", with: Wanerbu::Common::FORMAT_TELEPHONE}
end
