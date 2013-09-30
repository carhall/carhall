class Accounts::ProviderDetail < ActiveRecord::Base    
  extend Share::ImageAttachments
  define_rqrcode_image_method

  validates_presence_of :company, :phone
  
  acts_as_api

  api_accessible :base do |t|
    t.only :company, :phone, :rqrcode_token
  end

end
