class Accounts::ProviderDetail < ActiveRecord::Base    
  extend Share::ImageAttachments
  define_rqrcode_image_method

  validates_presence_of :company, :phone

  attr_accessor :dealer_type_id, :specific_service_id, :business_scope_ids, 
    :address, :open_during, :authentication_image
  attr_accessor :product_ids, :brand_ids

  Templates = {
    exposure: ["曝光台"],
    traffic_report: ["路况信息"],
  }

  TemplateSymbols = Templates.keys
  TemplateNames = Templates.values.map(&:first)
  TemplateNameMap = Templates.map { |k, v| [k, v[0]] }.to_h

  serialize :template_ids, Array
  enumerate :templates, with: TemplateNames, multiple: true

  def template_syms
    ids = template_ids.map{|i|i-1}
    TemplateSymbols.values_at(*ids)
  end

  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :company, :phone, :rqrcode_token, :template_ids, :templates
    end
  end
  
end
