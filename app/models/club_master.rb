class ClubMaster < ActiveRecord::Base
  include Share::Userable
  include Share::Areable
  include Share::Brandable

  scope :club, ->(area_id, brand_id) { where(area_id: area_id, brand_id: brand_id) }
  
  attr_accessible :user, :area_id, :brand_id, :area, :brand
end