module Tips::Servicable
  extend ActiveSupport::Concern

  included do
    include Share::Dealerable
    include Share::Displayable

    default_scope { order('id DESC') }
    
    before_save do
      self.area_id = dealer.area_id
      self.location_id = dealer.location_id
    end

    acts_as_api
  end
  
  module ClassMethods
    def api_accessible_for_detail
      api_accessible :detail, extend: :base do |t|
        t.add :goal_attainment, append_to: :detail
        t.add ->(s) { s.orders.unscoped.includes(:user).last(3) }, 
          as: :last_3_orders, append_to: :detail, template: :base
        t.add ->(s) { s.reviews.unscoped.includes(order: :user).last(3) }, 
          as: :last_3_reviews, append_to: :detail, template: :base
        t.add :dealer, template: :detail
      end
    end

    def set_order_class klass
      has_many :orders, class_name: klass, foreign_key: :source_id
      has_many :recent_orders, -> { where "orders.created_at > ?", 1.month.ago }, 
        class_name: klass, foreign_key: :source_id
      
      has_many :reviews, through: :orders
      has_many :recent_reviews, through: :recent_orders, class_name: 'Review'

    end
  end
end
