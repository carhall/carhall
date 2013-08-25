class Mending < ActiveRecord::Base
  belongs_to :dealer
  has_many :mending_orders, as: :source
  alias_attribute :orders, :mending_orders
  has_many :reviews, through: :mending_orders

  serialize :discount

  attr_accessible :dealer

  def serializable_hash(options={})
    options = { 
      only: [:id, :description, :mending_orders_count],
      methods: [:discount],
      include: [:dealer],
    }.update(options)
    super(options)
  end

end