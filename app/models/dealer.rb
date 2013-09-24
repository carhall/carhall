class Dealer < Account
  include Share::RqrcodeToken
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

  def has_template? template
    detail.template_syms.include? template
  end

  def self.with_location lat, lng, set_detail=false, details={}
    if set_detail
      Accounts::DealerDetail.with_location(lat, lng, false).each do |detail|
        details[detail.id] = detail
      end
      detail_ids = details.keys
    else
      detail_ids = Accounts::DealerDetail.with_location(lat, lng, false).pluck(:id)
    end

    records = where(detail_id: detail_ids)
    records = records.order("FIELD(detail_id, #{detail_ids.join(',')})") if detail_ids.any?
 
    if set_detail
      records.includes_values.delete :detail
      set_location locations
    end

    records
  end

  def set_detail details
    records = scoped
    records.each do |record|
      record.detail = details[record.detail_id]
    end
    records
  end

  def self.with_area area
    detail_ids = Accounts::DealerDetail.with_area(area).pluck(:id)
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
