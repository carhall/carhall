class Accounts::Dealer < Accounts::Account
  include Accounts::Publicable
  include Accounts::RqrcodeTokenable
  
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
  
  validates_presence_of :area_id, :type

  before_save do
    if area_changed?
      self.mending.update_attributes(area_id: self.area_id)
      self.cleanings.update_all(area_id: self.area_id)
      self.activities.update_all(area_id: self.area_id)
      self.bulk_purchasings.update_all(area_id: self.area_id)
    end

    # if detail.address_changed?
    #   self.mending.update_attributes(location_id: self.location_id)
    #   self.cleanings.update_all(location_id: self.location_id)
    #   self.activities.update_all(location_id: self.location_id)
    #   self.bulk_purchasings.update_all(location_id: self.location_id)
    # end
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

  def self.with_dealer_type dealer_type
    detail_ids = Accounts::DealerDetail.with_dealer_type(dealer_type).pluck(:id)
    where(detail_id: detail_ids)
  end
  
  def self.with_business_scope business_scope
    detail_ids = Accounts::DealerDetail.with_business_scope(business_scope).pluck(:id)
    where(detail_id: detail_ids)
  end

  def self.with_specific_service specific_service
    detail_ids = Accounts::DealerDetail.with_specific_service(specific_service).pluck(:id)
    where(detail_id: detail_ids)
  end

  def last_3_orders
    orders.includes(:user, source: [:dealer]).first(3)
  end

  def last_3_reviews
    reviews.includes(order: [:user, source: [:dealer]]).first(3)
  end

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

  api_accessible :detail_without_statistic, extend: :detail

  api_accessible :detail, extend: :detail do |t|
    t.add :area_id, append_to: :detail
    t.add :area, append_to: :detail
    t.add :stars, append_to: :detail
    t.add :mending_goal_attainment, append_to: :detail
    t.add :cleaning_goal_attainment, append_to: :detail
    t.add :bulk_purchasing_goal_attainment, append_to: :detail
    t.add :mending, template: :base, append_to: :without_dealer
    t.add :orders_count, append_to: :detail
    t.add :last_3_orders, append_to: :detail, template: :base
    # t.add :last_3_reviews, append_to: :detail, template: :base
  end

end
