class Tips::Review < ActiveRecord::Base
  belongs_to :order
  
  validates_presence_of :order
  validates_presence_of :stars
  validates_numericality_of :stars, greater_than_or_equal_to: 0, less_than_or_equal_to: 5, allow_nil: true
  
  default_scope { order('id DESC') }
  
  # before_create do
  #   order.user.detail.increment(:reviews_count)
  #   order.dealer.detail.increment(:reviews_count)
  #   order.source.increment(:reviews_count)
  #   order.dealer.detail.increment(:stars_count, stars)
  #   order.source.increment(:stars_count, stars)

  #   if order.type == 'MendingOrder'
  #     order.source.reviews_counts[order.detail.brand_id] ||= {}
  #     order.source.reviews_counts[order.detail.brand_id][order.detail.mending_type_id] ||= 0
  #     order.source.reviews_counts[order.detail.brand_id][order.detail.mending_type_id] += 1
  #     order.source.stars_counts[order.detail.brand_id] ||= {}
  #     order.source.stars_counts[order.detail.brand_id][order.detail.mending_type_id] ||= 0
  #     order.source.stars_counts[order.detail.brand_id][order.detail.mending_type_id] += stars
  #   end

  #   order.user.detail.save(validate: false)
  #   order.dealer.detail.save(validate: false)
  #   order.source.save(validate: false)

  # end

  # before_destroy do
  #   order.user.detail.decrement(:reviews_count)
  #   order.dealer.detail.decrement(:reviews_count)
  #   order.source.decrement(:reviews_count)
  #   order.dealer.detail.decrement(:stars_count, stars)
  #   order.source.decrement(:stars_count, stars)

  #   if order.type == 'MendingOrder'
  #     order.source.reviews_counts[order.detail.brand_id] ||= {}
  #     order.source.reviews_counts[order.detail.brand_id][order.detail.mending_type_id] -= 1
  #     order.source.stars_counts[order.detail.brand_id] ||= {}
  #     order.source.stars_counts[order.detail.brand_id][order.detail.mending_type_id] -= stars
  #   end

  #   order.user.detail.save(validate: false)
  #   order.dealer.detail.save(validate: false)
  #   order.source.save(validate: false)

  # end

  def to_without_order_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :content, :stars, :created_at
    end
  end

  def to_base_builder
    json = to_without_order_builder
    json.builder! self, :order, :base
    json
  end

  def to_detail_builder
    json = to_without_order_builder
    json.builder! self, :order, :detail
    json
  end

end
