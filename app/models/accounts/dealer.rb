class Accounts::Dealer < Accounts::Account
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
  
  validates_presence_of :type

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

  def self.with_area area
    detail_ids = Accounts::DealerDetail.with_area(area).pluck(:id)
    where(detail_id: detail_ids)
  end

  def self.with_dealer_type dealer_type
    detail_ids = Accounts::DealerDetail.with_dealer_type(dealer_type).pluck(:id)
    where(detail_id: detail_ids)
  end
  
  def self.with_business_scope business_scope
    detail_ids = Accounts::DealerDetail.with_business_scope(business_scope).pluck(:id)
    where(detail_id: detail_ids)
  end

  api_accessible :detail, extend: :detail do |t|
    t.add :stars, append_to: :detail
    t.add ->(d) { Share::Statisticable.goal_attainment d.mending_orders }, 
      as: :mending_goal_attainment, append_to: :detail
    t.add ->(d) { Share::Statisticable.goal_attainment d.cleaning_orders }, 
      as: :cleaning_goal_attainment, append_to: :detail
    t.add ->(d) { Share::Statisticable.goal_attainment d.bulk_purchasing_orders }, 
      as: :bulk_purchasing_goal_attainment, append_to: :detail
    t.add :mending, template: :base, append_to: :detail
    t.add :orders_count, append_to: :detail
    t.add ->(d) { d.orders.unscoped.includes(:user).last(3) }, as: :last_3_orders, 
      append_to: :detail, template: :base
    t.add ->(d) { d.reviews.unscoped.includes(order: :user).last(3) }, as: :last_3_reviews,
      append_to: :detail, template: :base
  end

end
