module Tips::Servicable
  extend ActiveSupport::Concern

  included do
    include Share::Dealerable
    include Share::Displayable
    
    include Share::Areable
    include Share::Localizable

    default_scope { order('id DESC') }
    scope :ordered, -> { displayed.positioned }
    scope :followed_by, -> (user) { with_dealer(user.dealer_friends) }
    
    before_save do
      self.area_id = dealer.area_id if self.respond_to? :area_id
      self.location_id = dealer.location_id if self.respond_to? :location_id
    end
  end

  module ClassMethods

    def to_detail_builder
      define_method :to_detail_builder do
        json = to_base_builder
        json.detail do
          json.extract! self, :goal_attainment
          json.last_3_orders(orders.includes(:user).reorder('id DESC').first(3).map{|o|o.to_base_builder.attributes!})
          json.last_3_reviews(reviews.includes(order:[:user]).first(3).map{|o|o.to_base_builder.attributes!})
        end
        json.builder! self, :dealer, :detail_without_statistic
        json
      end
    end

    def set_order_class klass
      has_many :orders, class_name: klass, foreign_key: :source_id
      has_many :recent_orders, -> { where "orders.created_at > ?", 1.month.ago }, 
        class_name: klass, foreign_key: :source_id
      
      has_many :reviews, through: :orders
      has_many :recent_reviews, through: :recent_orders, class_name: 'Tips::Review'

    end
  end
end
