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

  def total_cost_with_dealer dealer_id
    Share::Statisticable.total_cost orders.select{|o|o.dealer_id == dealer_id}
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
    order = if recent_orders.loaded?
      recent_orders
    else
      orders
    end.first
    order.created_at if order
  end

  def last_ordered_at_with_dealer dealer_id
    order = if recent_orders.loaded?
      recent_orders
    else
      orders
    end.detect{|o|o.dealer_id == dealer_id}
    order.created_at if order
  end

  extend Share::MethodCache
  define_cached_methods :stars, :recent_stars, :recent_orders_count, 
    :total_cost, :recent_total_cost, :recent_ordered_users_count, 
    :goal_attainment, :last_ordered_at, :last_ordered_at_with_dealer, 
    expires_in: 1.hour

end
