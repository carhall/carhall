class Cleaning < ActiveRecord::Base
  belongs_to :dealer
  has_many :cleaning_orders, foreign_key: :source_id
  alias_attribute :orders, :cleaning_orders
  has_many :reviews, through: :cleaning_orders

  extend Share::ImageAttachments
  define_image_method

  attr_accessible :title, :cleaning_type_id, :price, :vip_price, :description, :image

  validates_presence_of :dealer
  validates_presence_of :title, :cleaning_type_id, :price, :vip_price

  extend Share::Id2Key
  CleaningTypes = %w(洗车 漆面养护 清洁护理)
  define_id2key_methods :cleaning_type

  def serializable_hash(options={})
    options = { 
      only: [:id, :title, :cleaning_type_id, :price, :vip_price, :description, :orders_count],
      methods: [:cleaning_type],
      images: [:image],
      include: [:dealer],
    }.update(options)
    super(options)
  end

end
