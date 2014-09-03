class Tips::RescueOrder < Tips::Order
  include Tips::Servicable
  set_order_class Tips::RescueOrder
  


  include Share::Statisticable



  validates_presence_of :title

  def set_title
    #I18n.t(".vehicle_insurance", dealer: dealer.username)
  end
end
