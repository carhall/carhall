class Accounts::DistributorDetail < ActiveRecord::Base
  extend Share::ImageAttachments
  define_image_method
  alias_attribute :authentication_image, :image

  define_rqrcode_image_method
  
  validates_presence_of :business_scope_ids, :company, :address, :phone

  # enumerate :distributor_type, with: %w(洗车美容 专项服务 专修 4S店)

  serialize :business_scope_ids, Array
  enumerate :business_scopes, with: %w(汽车用品 洗车美容工具 汽保工具 美容养护 深化养护 汽车配件 电子产品), multiple: true

  enumerate :specific_service, with: %w(轮胎 换油 改装 钣喷 空调)

  serialize :product_ids, Array
  enumerate :products, with: Category::Product, multiple: true

  serialize :brand_ids, Array
  enumerate :brands, with: Category::Brand, multiple: true

  attr_accessor :dealer_type_id, :specific_service_id, :open_during

  scope :with_business_scope, -> (name) {
    id = active_enum_get_id_for_business_scopes(name)
    where('business_scope_ids LIKE \'%- ?\n%\'', id)
  }

  scope :with_product, -> (name) {
    id = active_enum_get_id_for_products(name)
    where('product_ids LIKE \'%- ?\n%\'', id)
  }

  serialize :template_ids, Array
  enumerate :templates, with: %w(洗车美容 保养专修 团购 近期活动), multiple: true

  def template_syms
    ids = template_ids.map{|i|i-1}
    %i(cleaning mending bulk_purchasing activity).values_at(*ids)
  end

end
