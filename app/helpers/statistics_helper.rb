module StatisticsHelper
  def stars reviews
    return 0.0 unless reviews.any?
    reviews.map(&:stars).reduce(0.0, :+) / reviews.size
  end

  def total_cost orders
    return 0 unless orders.any?
    orders.map(&:cost).reduce(:+)
  end

  def users_count resources
    return 0 unless resources.any?
    resources.map(&:user).uniq.count
  end

  def trend resources
    resources.select{|r|r.created_at>1.month.ago}
  end

  def last_ordered_at orders
    orders.last.created_at if orders.any?
  end

  def last_stars reviews
    reviews.last.stars if reviews.any?
  end

  def states_count orders, state
    state_id = Share::Statable.get_id state
    orders.select{|o|o.state_id == state_id}.count
  end

  def goal_attainment orders
    uncanceled_count = orders.count - states_count(orders, :canceled)
    return 0.0 if uncanceled_count == 0
    states_count(orders, :finished) / uncanceled_count
  end

  def print_stars reviews
    ret = ""
    fStars = stars(reviews)
    iStars = fStars.round
    iStars.times { ret << '<i class="icon-star"></i> ' }
    (5 - iStars).times { ret << '<i class="icon-star-empty"></i> ' }
    ret << fStars.round(2).to_s
    ret.html_safe
  end

end
