class Dealer < BaseUser
  include Auth::RqrcodeToken

  set_detail_class Auth::DealerInfo

  has_one :mending
  has_many :cleanings
  has_many :activities
  has_many :bulk_purchasings

  has_many :mending_orders, through: :mending
  has_many :cleaning_orders, through: :cleanings
  has_many :bulk_purchasing_orders, through: :bulk_purchasings


  has_many :orders, class_name: 'BaseOrder'
  has_many :reviews, through: :orders

  def has_template? template
    detail.template_syms.include? template
  end

end
