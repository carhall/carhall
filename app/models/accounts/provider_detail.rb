class Accounts::ProviderDetail < ActiveRecord::Base    
  extend Share::ImageAttachments
  define_rqrcode_image_method

  validates_presence_of :company, :phone

  attr_accessor :dealer_type_id, :specific_service_id, :business_scope_ids, 
    :address, :open_during, :authentication_image
  attr_accessor :product_ids, :brand_ids

  serialize :template_ids, Array
  enumerate :templates, with: %w(曝光台 路况信息), multiple: true

  def template_syms
    ids = template_ids.map{|i|i-1}
    %i(exposure traffic_report).values_at(*ids)
  end
  acts_as_api

  api_accessible :base do |t|
    t.only :company, :phone, :rqrcode_token, :template_ids
    t.methods :templates
  end

end
