class Accounts::ProviderDetail < ActiveRecord::Base    
  extend Share::ImageAttachments
  define_rqrcode_image_method

  validates_presence_of :company, :phone

  attr_accessor :dealer_type_id, :specific_service_id, :business_scope_ids, 
    :address, :open_during, :authentication_image
  acts_as_api

  api_accessible :base do |t|
    t.only :company, :phone, :rqrcode_token
  end

end
