class Order < ActiveRecord::Base
  # For details
  include Share::Detailable

  include Tips::Statable
  include Share::Userable
  belongs_to :user, counter_cache: true

  belongs_to :dealer, counter_cache: true
  has_one :review

  validates_presence_of :source, :user 
  
  before_create do
    self.dealer_id = source.dealer_id
    self.title = set_title
    self.cost = set_cost

    # user.detail.increment(:orders_count)
    # dealer.detail.increment(:orders_count)
    # user.detail.increment(:total_spend, cost)
    # dealer.detail.increment(:total_sale, cost)
    # source.increment(:total_sale, cost)

    # if type == 'MendingOrder'
    #   source.orders_counts[detail.brand_id] ||= {}
    #   source.orders_counts[detail.brand_id][detail.mending_type_id] ||= 0
    #   source.orders_counts[detail.brand_id][detail.mending_type_id] += 1
    #   source.total_sales[detail.brand_id] ||= {}
    #   source.total_sales[detail.brand_id][detail.mending_type_id] ||= 0
    #   source.total_sales[detail.brand_id][detail.mending_type_id] += cost
    # end

    # user.detail.save(validate: false)
    # dealer.detail.save(validate: false)
    # source.save(validate: false)

  end

  # before_destroy do
  #   user.detail.decrement(:orders_count)
  #   dealer.detail.decrement(:orders_count)
  #   user.detail.decrement(:total_spend, cost)
  #   dealer.detail.decrement(:total_sale, cost)
  #   source.decrement(:total_sale, cost)

  #   if type == 'MendingOrder'
  #     source.orders_counts[detail.brand_id] ||= {}
  #     source.orders_counts[detail.brand_id][detail.mending_type_id] -= 1
  #     source.total_sales[detail.brand_id] ||= {}
  #     source.total_sales[detail.brand_id][detail.mending_type_id] -= cost
  #   end

  #   user.detail.save(validate: false)
  #   dealer.detail.save(validate: false)
  #   source.save(validate: false)

  # end

  def set_title
    "#{source.title}#{I18n.t(".times", count: count) if count}" 
  end

  def set_cost
    cost = source.price if source.respond_to? :price
    cost *= count if count
  end

  def order_type
    return :order unless type
    type.underscore.to_sym
  end

  acts_as_api

  api_accessible :base do |t|
    t.only :id, :title
    t.methods :order_type
    t.add :user, template: :base
  end
  
end
