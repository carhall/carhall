module Users::ReviewsHelper
  def stars reviews
    reviews.map(&:stars).reduce(:+) / reviews.size if reviews.any?
  end

  def total_cost orders
    orders.map(&:cost).reduce(:+) if orders.any?
  end

  def trend_stars reviews
    return nil if reviews.empty?
    trend_reviews = reviews.select{|r|r.created_at>1.month.ago}
    trend_reviews.map(&:stars).reduce(:+) / trend_reviews.size
  end

  def last_ordered_at orders
    orders.last.created_at if orders.any?
  end

  def last_stars reviews
    reviews.last.stars if reviews.any?
  end
  
end
