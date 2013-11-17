module Share::Statisticable 
  extend ActiveSupport::Concern

  included do
    scope :cheapie, -> { order('vip_price ASC') }
    scope :favorite, -> { all.sort{|s|s.stars} }
    scope :hot, -> { order('orders_count DESC') }
  end

  class << self
    include StatisticsHelper
  end
  
  def stars
    Share::Statisticable.mean_stars reviews
  end

  def human_stars
    stars.round(2)
  end

  def last_stars
    review = if reviews.loaded?
      reviews.first
    elsif recent_reviews.loaded?
      recent_reviews.first
    else
      reviews.first
    end
    review.stars if review
  end

  def recent_stars
    if reviews.loaded?
      target_reviews = Share::Statisticable.recent reviews
    else
      target_reviews = recent_reviews
    end
    Share::Statisticable.mean_stars target_reviews
  end

  def human_recent_stars
    recent_stars.round(2)
  end

  def recent_orders_count
    recent_orders.length
  end

  def total_cost
    Share::Statisticable.total_cost orders
  end

  def recent_total_cost
    Share::Statisticable.total_cost recent_orders
  end

  def recent_ordered_users_count
    Share::Statisticable.ordered_users_count recent_orders
  end

  def goal_attainment
    Share::Statisticable.goal_attainment orders
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

  extend Share::MethodCache
  define_cached_methods :stars, :recent_stars, :recent_orders_count, 
    :total_cost, :recent_total_cost, :recent_ordered_users_count, 
    :goal_attainment, expires_in: 1.hour

end
