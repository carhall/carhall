module Share
  module Servicable
    extend ActiveSupport::Concern

    included do
      belongs_to :dealer
      default_scope { order('id DESC') }
      
      before_save do
        self.area_id = dealer.detail.area_id
        self.location_id = dealer.location_id
      end

    end

    def detail_hash
      detail_hash = {}
      detail_hash[:goal_attainment] = goal_attainment
      detail_hash[:last_3_orders] = orders.includes(:user).last(3)
      detail_hash[:last_3_reviews] = reviews.includes(order: :user).last(3)
      serializable_hash(include: {dealer: {include: :detail}}).merge(detail: detail_hash)
    end
    
    module ClassMethods 
      def set_order_class klass
        has_many :orders, class_name: klass, foreign_key: :source_id
        has_many :recent_orders, conditions: ["orders.created_at > ?", 1.month.ago], 
          class_name: klass, foreign_key: :source_id
        
        has_many :reviews, through: :orders
        has_many :recent_reviews, through: :recent_orders, class_name: Review

      end
    end
  end
end