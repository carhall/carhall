class Tips::VehicleInsuranceOrder < Tips::Order
  set_detail_class Tips::VehicleInsuranceOrderDetail
  delegate :brand, :insurance_type, to: :detail, allow_nil: true

  validates_presence_of :detail, :dealer

  def set_title
    I18n.t(".vehicle_insurance", dealer: dealer.username, brand: detail.brand)
  end

  def set_cost; 0; end
  def source; true; end
  def use(count); finish; end
  def used?; finished?; end
  
end
