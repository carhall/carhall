class Dealer < Account
  include Share::RqrcodeToken

  include Share::Localizable
  include Share::Statisticable

  set_detail_class Accounts::DealerDetail

  has_one :mending
  has_many :cleanings
  has_many :activities
  has_many :bulk_purchasings

  has_many :orders
  has_many :recent_orders, conditions: ["orders.created_at > ?", 1.month.ago], class_name: Order

  has_many :mending_orders, class_name: MendingOrder
  has_many :cleaning_orders, class_name: CleaningOrder
  has_many :bulk_purchasing_orders, class_name: BulkPurchasingOrder

  has_many :reviews, through: :orders
  has_many :recent_reviews, through: :recent_orders, class_name: Review
  
  validates_presence_of :type

  validates_each :detail do |record, attr, value|
    if value.address_changed?
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

  def detail_hash
    detail_hash = detail.serializable_hash
    detail_hash[:mending_goal_attainment] = Share::Statisticable.goal_attainment mending_orders
    detail_hash[:cleaning_goal_attainment] = Share::Statisticable.goal_attainment cleaning_orders
    detail_hash[:bulk_purchasing_goal_attainment] = Share::Statisticable.goal_attainment bulk_purchasing_orders
    detail_hash[:orders_count] = orders.count

    detail_hash[:last_3_orders] = orders.includes(:user).last(3)
    detail_hash[:last_3_reviews] = reviews.includes(order: :user).last(3)
    serializable_hash.merge(detail: detail_hash)
  end

end
