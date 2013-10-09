class Accounts::UserDetail < ActiveRecord::Base
  extend Share::ImageAttachments
  define_image_method
  alias_attribute :car_image, :image
  
  acts_as_api

  api_accessible :base do |t|
    t.only :series, :plate_num, :balance
    t.images :car_image
  end

end
