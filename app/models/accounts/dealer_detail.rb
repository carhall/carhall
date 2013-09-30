class Accounts::DealerDetail < ActiveRecord::Base
  enumerate :area, with: Share::Area

  extend Share::ImageAttachments
  define_image_method
  alias_attribute :authentication_image, :image

  # attr_accessible :area_id, :dealer_type_id, :business_scope_ids, :template_ids, 
  #   :company, :address, :phone, :open_during, :accepted, :authentication_image
  # attr_accessible :area, :dealer_type, :business_scopes, :templates 
  # attr_accessible :location

  validates_presence_of :area_id, :dealer_type_id, :business_scope_ids,
    :company, :address, :phone, :open_during, :authentication_image

  enumerate :dealer_type, with: %w(洗车美容 专项服务 专修 4S店)

  serialize :business_scope_ids
  enumerate :business_scopes, with: %w(洗车 美容 轮胎 换油 改装 钣喷 空调 专修 保险), multiple: true

  def self.with_business_scope name
    id = active_enum_get_id_for_business_scopes(name)
    where('business_scope_ids LIKE \'%- ?\n%\'', id)
  end

  serialize :template_ids
  enumerate :templates, with: %w(洗车美容 保养专修 团购 近期活动), multiple: true

  enumerate :template_syms, with: %i(cleaning mending bulk_purchasing activity), 
    column: :template_ids, multiple: true

  acts_as_api

  api_accessible :base do |t|
    t.only :area_id, :dealer_type_id, :business_scope_ids, :company, :address, 
        :phone, :open_during, :latitude, :longitude, :rqrcode_token, 
        :orders_count, :reviews_count
    t.methods :area, :dealer_type, :business_scopes
  end

end
