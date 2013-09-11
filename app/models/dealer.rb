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
  has_many :reviews

  validates_presence_of :type

  def has_template? template
    detail.template_syms.include? template
  end

end
