class Statistic::ConsumptionRecord < ActiveRecord::Base
  include Share::Userable
  include Share::Dealerable
  belongs_to :order, polymorphic: true

  before_save do
    if order
      self.order_title ||= order.title
      self.order_type = order.class.name
      original_order = order.try(:vip_card_order) || order
      self.user_id = original_order.user_id
      self.dealer_id = original_order.dealer_id
    end
  end

end
