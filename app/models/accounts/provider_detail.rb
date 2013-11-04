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

  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :company, :phone, :rqrcode_token, :template_ids, :templates
    end
  end
  
end
