class Accounts::Dealer < Accounts::PublicAccount
  include Share::Localizable
  include Share::Statisticable

  set_detail_class Accounts::DealerDetail

  has_one :mending, class_name: 'Tips::Mending'
  has_many :cleanings, class_name: 'Tips::Cleaning'
  has_many :activities, class_name: 'Tips::Activity'
  has_many :bulk_purchasings, class_name: 'Tips::BulkPurchasing'

  has_many :orders, class_name: 'Tips::Order'
  has_many :recent_orders, -> { where "orders.created_at > ?", 1.month.ago }, class_name: 'Tips::Order'

  has_many :mending_orders, class_name: 'Tips::MendingOrder'
  has_many :cleaning_orders, class_name: 'Tips::CleaningOrder'
  has_many :bulk_purchasing_orders, class_name: 'Tips::BulkPurchasingOrder'

  has_many :reviews, through: :orders, class_name: 'Tips::Review'
  has_many :recent_reviews, through: :recent_orders, class_name: 'Tips::Review'
  
  before_save do
    if area_changed?
      self.mending.update_attributes(area_id: self.area_id) if self.mending
      self.cleanings.update_all(area_id: self.area_id)
      self.activities.update_all(area_id: self.area_id)
      self.bulk_purchasings.update_all(area_id: self.area_id)
    end
  end

  validates_each :detail do |record, attr, value|
    if value and value.address_changed?
      bmap_geocoding_url = "http://api.map.baidu.com/geocoder/v2/?ak=E5072c8281660dfc534548f8fda2be11&output=json&address=#{value.address}"
      begin
        result = JSON.parse(open(URI::encode(bmap_geocoding_url)).read)
        logger.info("  Requested BMap API #{bmap_geocoding_url}")
        logger.info("  Result: #{result['result'] rescue result}")
        if result['status'] == 0 and result['result'] and result['result'].any?
          record.location_attributes = {
            latitude: result['result']['location']['lat'],
            longitude: result['result']['location']['lng']
          }
        else
          value.errors.add(:address, :invalid)
        end
      rescue Exception => e
        record.errors.add(:base, e.message)
      end
    end
  end

  def has_template? template
    detail.template_syms.include? template
  end

  scope :with_dealer_type, -> (dealer_type) {
    detail_ids = Accounts::DealerDetail.with_dealer_type(dealer_type).pluck(:id)
    where(detail_id: detail_ids)
  }

  scope :with_business_scope, -> (business_scope) {
    detail_ids = Accounts::DealerDetail.with_business_scope(business_scope).pluck(:id)
    where(detail_id: detail_ids)
  } 

  scope :with_specific_service, -> (specific_service) {
    detail_ids = Accounts::DealerDetail.with_specific_service(specific_service).pluck(:id)
    where(detail_id: detail_ids)
  }

  def mending_goal_attainment
    Share::Statisticable.goal_attainment mending_orders
  end

  def cleaning_goal_attainment
    Share::Statisticable.goal_attainment cleaning_orders
  end

  def bulk_purchasing_goal_attainment
    Share::Statisticable.goal_attainment bulk_purchasing_orders
  end

  extend Share::MethodCache
  define_cached_methods :mending_goal_attainment, :cleaning_goal_attainment, 
    :bulk_purchasing_goal_attainment

  def to_detail_without_statistic_builder
    json = to_base_builder
    json.detail do
      json.attributes!.merge! detail.to_base_builder.attributes!
      json.extract! self, :area_id, :area
      if location
        json.latitude location.latitude
        json.longitude location.longitude
      end
    end
    json
  end

  def to_detail_builder
    json = to_base_builder
    json.detail do
      json.attributes!.merge! detail.to_base_builder.attributes!
      json.extract! self, :area_id, :area, :stars, :mending_goal_attainment,
        :cleaning_goal_attainment, :bulk_purchasing_goal_attainment,
        :orders_count
      if location
        json.latitude location.latitude
        json.longitude location.longitude
      end
      json.builder! self, :mending, :without_dealer
      json.last_3_orders(orders.includes(:user).last(3).map{|o|o.to_base_builder.attributes!})
    end
    json
  end

end
