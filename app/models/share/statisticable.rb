module Share
  module Statisticable 
    extend ActiveSupport::Concern

    class << self
      include StatisticsHelper
    end
    
    def stars
      Statisticable.mean_stars reviews
    end

    def last_stars
      review = if reviews.loaded?
        reviews.last
      elsif recent_reviews.loaded?
        recent_reviews.last
      else
        reviews.last
      end
      review.stars if review
    end

    def recent_stars
      if reviews.loaded?
        target_reviews = Statisticable.recent reviews
      else
        target_reviews = recent_reviews
      end
      Statisticable.mean_stars target_reviews
    end

    def recent_orders_count
      recent_orders.length
    end

    def total_cost
      Statisticable.total_cost orders
    end

    def recent_total_cost
      Statisticable.total_cost recent_orders
    end

    def recent_ordered_users_count
      Statisticable.ordered_users_count recent_orders
    end

    def goal_attainment
      Statisticable.goal_attainment orders
    end

    def last_ordered_at
      order = if orders.loaded?
        orders.last
      elsif recent_orders.loaded?
        recent_orders.last
      else
        orders.last
      end
      order.created_at if order
    end

  end
end