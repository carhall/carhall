class Dealer < User
  include Auth::RqrcodeToken

  set_detail_class Auth::DealerDetail

  has_one :mending
  has_many :cleanings
  has_many :activities
  has_many :bulk_purchasings

  has_many :mending_orders, through: :mending
  has_many :cleaning_orders, through: :cleanings
  has_many :bulk_purchasing_orders, through: :bulk_purchasings


  has_many :orders, class_name: 'Order'
  has_many :reviews, through: :orders

  validates_presence_of :user_type_id

  def has_template? template
    detail.template_syms.include? template
  end

end
