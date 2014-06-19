class Accounts::DealerDetail < ActiveRecord::Base
  extend Share::ImageAttachments
  define_image_method
  alias_attribute :authentication_image, :image

  define_rqrcode_image_method
  
  validates_presence_of :dealer_type_id, :business_scope_ids,
    :company, :address, :phone, :open_during, :authentication_image

  enumerate :dealer_type, with: %w(洗车美容 专项服务 专修 4S店 汽车销售)

  serialize :business_scope_ids, Array
  enumerate :business_scopes, with: %w(洗车 美容 轮胎 换油 改装 钣喷 空调 专修 保险 卖车), multiple: true

  enumerate :specific_service, with: %w(轮胎 换油 改装 钣喷 空调)

  attr_accessor :product_ids, :brand_ids

  scope :with_business_scope, -> (name) {
    id = active_enum_get_id_for_business_scopes(name)
    where('business_scope_ids LIKE \'%- ?\n%\'', id)
  }

  Templates = {
    cleaning: ["服务项目", "普通会员", %w(洗车美容 专项服务 专修 4S店)],
    mending: ["保养专修", "黄金会员", %w(专修 4S店)],
    bulk_purchasing: ["团购", "体验会员", %w(洗车美容 专项服务 专修 4S店 汽车销售)],
    activity: ["活动", "体验会员", %w(洗车美容 专项服务 专修 4S店 汽车销售)],
    vip_card: ["会员卡", "体验会员", %w(洗车美容 专项服务 专修 4S店)],
    test_driving: ["看车试驾", "白金会员", %w(4S店 汽车销售)],
    construction_case: ["施工案例", "普通会员", %w(洗车美容 专项服务)],
    vehicle_insurance: ["车险续保", "黄金会员", %w(专修 4S店 汽车销售)],
    secondhand_appraise: ["二手评估", "白金会员", %w(4S店 汽车销售)],
    bulk_purchasing2: ["限时求购", nil, %w(洗车美容 专项服务 专修 4S店 汽车销售)],
    buying_advice: ["易卖车", "钻石会员", %w(4S店 汽车销售)],
  }

  Ranks = [
    ["体验会员", %w(洗车美容 专项服务)],
    ["普通会员", %w()],
    ["黄金会员", %w(专修)],
    ["白金会员", %w(汽车销售)],
    ["钻石会员", %w(4S店)],
  ]

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
      json.extract! self, :dealer_type_id, :dealer_type, :business_scope_ids, :business_scopes,
        :company, :address, :phone, :open_during, :rqrcode_token
    end
  end

end
