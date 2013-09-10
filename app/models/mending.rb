class Mending < ActiveRecord::Base
  belongs_to :dealer
  has_many :mending_orders, as: :source
  alias_attribute :orders, :mending_orders

  has_many :reviews, through: :mending_orders

  serialize :discount, Hash

  extend Share::Id2Key
  Brands = Share::Brandable::Brands
  define_ids2keys_methods :brands

  attr_accessible :dealer
  attr_accessible :discount, :brand_ids
  attr_accessible :brands

  def serializable_hash(options={})
    options = { 
      only: [:id, :brand_ids, :description, :orders_count],
      methods: [:brands, :discount],
      include: [:dealer],
    }.update(options)
    super(options)
  end

end