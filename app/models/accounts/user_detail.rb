class Accounts::UserDetail < ActiveRecord::Base
  enumerate :area, with: Share::Area
  enumerate :brand, with: Share::Brand

  extend Share::ImageAttachments
  define_image_method
  alias_attribute :car_image, :image
  
  attr_accessible :sex_id, :area_id, :brand_id, :series, :plate_num, :car_image
  attr_accessible :sex, :area, :brand

  enumerate :sex, with: %w(男 女)

  acts_as_api

  api_accessible :base do |t|
    t.only :sex_id, :area_id, :brand_id, :series, :plate_num, :balance, :posts_count
    t.methods :sex, :area, :brand
    t.images :car_image
  end

end
