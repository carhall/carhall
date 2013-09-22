class Dealer < Account
  include Share::RqrcodeToken
  include Share::Statisticable

  set_detail_class Accounts::DealerDetail

  has_one :mending
  has_many :cleanings
  has_many :activities
  has_many :bulk_purchasings

  has_many :mending_orders, through: :mending
  has_many :cleaning_orders, through: :cleanings
  has_many :bulk_purchasing_orders, through: :bulk_purchasings

  has_many :orders
  has_many :recent_orders, conditions: ["orders.created_at > ?", 1.month.ago], class_name: Order

  has_many :mending_reviews, source: :reviews, through: :mending
  has_many :cleaning_reviews, source: :reviews, through: :cleanings
  has_many :bulk_purchasing_reviews, source: :reviews, through: :bulk_purchasings

  has_many :reviews, through: :orders
  has_many :recent_reviews, source: :review, through: :recent_orders
  
  validates_presence_of :type

  def has_template? template
    detail.template_syms.include? template
  end

  def self.with_location lat, lng
    detail_ids = Accounts::DealerDetail.where(latitude: (lat-0.1..lat+0.1), longitude: (lng-0.1..lng+0.1)).pluck(:id)
    where(detail_id: detail_ids).sort do |resource|
      dealer_detail.latitude**2 + dealer_detail.longitude**2
    end
  end

  def self.with_area area
    area_id = Share::Areable.get_id area
    detail_ids = Accounts::DealerDetail.where(area_id: area_id).pluck(:id)
    where(detail_id: detail_ids)
  end

end
