class Accounts::DealerDetail < ActiveRecord::Base
  include Share::Localizable
  include Share::RatingCachable
  
  extend Share::ImageAttachments
  define_image_method
  alias_attribute :authentication_image, :image

  attr_accessible :area_id, :dealer_type_id, :business_scope_ids, :template_ids, 
    :company, :address, :phone, :open_during, :accepted, :authentication_image
  attr_accessible :area, :dealer_type, :business_scopes, :templates 
  attr_accessible :location

  validates_presence_of :area_id, :dealer_type_id, :business_scope_ids,
    :company, :address, :phone, :open_during, :authentication_image

  validates_each :address do |record, attr, value|
    if record.address_changed?
      bmap_geocoding_url = "http://api.map.baidu.com/geocoder/v2/?ak=E5072c8281660dfc534548f8fda2be11&output=json&address=#{value}"
      begin
        result = JSON.parse(open(URI::encode(bmap_geocoding_url)).read)
        if result['status'] == 0 and result['result'] and result['result'].any?
          logger.info("  Requested BMap API #{bmap_geocoding_url}")
          logger.info("  Result: #{result['result']}")
          record.location = Share::Location.new(
            latitude: result['result']['location']['lat'],
            longitude: result['result']['location']['lng']
          )
        else
          record.errors.add(attr, :invalid)
        end
      rescue Exception => e
        record.errors.add(:base, e.message)
      end
    end
  end

  extend Share::Id2Key

  DealerTypes = %w(洗车美容 专项服务 专修 4S店)
  define_id2key_methods :dealer_type

  BusinessScopes = %w(洗车 美容 轮胎 换油 改装 钣喷 空调 专修 保险)
  define_ids2keys_methods :business_scopes

  Templates = %w(洗车美容 保养专修 团购 近期活动)
  define_ids2keys_methods :templates

  TemplateSyms = %i(cleaning mending bulk_purchasing activity)
  def template_syms
    @template_syms ||= template_ids.map do |id|
      TemplateSyms[id]
    end
  end

  def serializable_hash(options={})
    options = { 
      only: [:dealer_type_id, :business_scope_ids, :company, :address, 
        :phone, :open_during, :latitude, :longitude, :rqrcode_token, 
        :orders_count, :reviews_count],
      methods: [:dealer_type, :business_scopes],
    }.update(options)
    super(options)
  end

end
