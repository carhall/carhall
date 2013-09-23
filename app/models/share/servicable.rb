module Share
  module Servicable
    extend ActiveSupport::Concern

    included do
      belongs_to :dealer
      default_scope { order('id DESC') }
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