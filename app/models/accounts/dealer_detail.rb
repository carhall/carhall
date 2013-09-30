class Accounts::DealerDetail < ActiveRecord::Base
  enumerate :area, with: Share::Area

  extend Share::ImageAttachments
  define_image_method
  alias_attribute :authentication_image, :image

  define_rqrcode_image_method
  
  validates_presence_of :area_id, :dealer_type_id, :business_scope_ids,
    :company, :address, :phone, :open_during, :authentication_image

  enumerate :dealer_type, with: %w(洗车美容 专项服务 专修 4S店)

  serialize :business_scope_ids, Array
  enumerate :business_scopes, with: %w(洗车 美容 轮胎 换油 改装 钣喷 空调 专修 保险), multiple: true

  def self.with_business_scope name
    id = active_enum_get_id_for_business_scopes(name)
    where('business_scope_ids LIKE \'%- ?\n%\'', id)
  end

  serialize :template_ids, Array
  enumerate :templates, with: %w(洗车美容 保养专修 团购 近期活动), multiple: true

  def template_syms
    ids = template_ids.map{|i|i-1}
    %i(cleaning mending bulk_purchasing activity).values_at(*ids)
  end

  acts_as_api

  api_accessible :base do |t|
    t.only :area_id, :dealer_type_id, :business_scope_ids, :company, :address, 
        :phone, :open_during, :latitude, :longitude, :rqrcode_token, 
        :orders_count, :reviews_count
    t.methods :area, :dealer_type, :business_scopes
  end

end
