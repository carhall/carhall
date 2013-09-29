class Accounts::ProviderDetail < ActiveRecord::Base    
  attr_accessible :company, :phone

  validates_presence_of :company, :phone
  
  # Fake attributes
  attr_accessor :area_id, :dealer_type_id, :business_scope_ids, :address, :open_during, :authentication_image
  attr_accessible :area_id, :dealer_type_id, :business_scope_ids, :address, :open_during, :authentication_image

  acts_as_api

  api_accessible :base do |t|
    t.only :company, :phone, :rqrcode_token
  end

end
