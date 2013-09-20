class Dealer < Account
  include Share::RqrcodeToken

  set_detail_class Accounts::DealerDetail

  has_one :mending
  has_many :cleanings
  has_many :activities
  has_many :bulk_purchasings

  has_many :mending_orders, through: :mending
  has_many :cleaning_orders, through: :cleanings
  has_many :bulk_purchasing_orders, through: :bulk_purchasings

  has_many :orders

  has_many :mending_reviews, source: :reviews, through: :mending
  has_many :cleaning_reviews, source: :reviews, through: :cleanings
  has_many :bulk_purchasing_reviews, source: :reviews, through: :bulk_purchasings

  has_many :reviews, through: :orders

  validates_presence_of :type

  def has_template? template
    detail.template_syms.include? template
  end

  def self.with_location lat, lng
    detail_ids = Accounts::DealerDetail.where(latitude: (lat-0.1..lat+0.1), longitude: (lng-0.1..lng+0.1)).pluck(:id)
    Dealer.where(detail_id: detail_ids)
  end

end
