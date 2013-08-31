class Cleaning < ActiveRecord::Base
  belongs_to :dealer
  has_many :cleaning_orders, as: :source
  alias_attribute :orders, :cleaning_orders
  has_many :reviews, through: :cleaning_orders

  extend Share::ImageFile
  define_image_methods :image

  def serializable_hash(options={})
    options = { 
      only: [:id, :title, :typehood, :price, :vip_price, :description, :cleaning_orders_count],
      methods: [:image_thumb_url, :image_url],
      include: [:dealer],
    }.update(options)
    super(options)
  end

end