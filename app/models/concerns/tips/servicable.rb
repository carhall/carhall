module Tips::Servicable
  extend ActiveSupport::Concern

  included do
    belongs_to :dealer, class_name: 'Accounts::Dealer'
    default_scope { order('id DESC') }
    
    before_save do
      self.area_id = dealer.detail.area_id
      self.location_id = dealer.location_id
    end

    acts_as_api

    api_accessible :detail do |t|
      t.add :goal_attainment, append_to: :detail
      t.add ->(s) { s.orders.includes(:user).last(3) }, 
        as: :last_3_orders, append_to: :detail, template: :base
      t.add ->(s) { s.reviews.includes(order: :user).last(3) }, 
        as: :last_3_reviews, append_to: :detail, template: :base
      t.add :dealer, template: :detail
    end
  end
  
  module ClassMethods 
    def with_dealer dealer
      dealer_id = if dealer.is_a? Integer then dealer else dealer.id end
      where(dealer_id: dealer_id)
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
