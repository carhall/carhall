class Cleaning < ActiveRecord::Base
  belongs_to :dealer
  has_many :cleaning_orders, as: :source
  alias_attribute :orders, :cleaning_orders
  has_many :reviews, through: :cleaning_orders

  has_attached_file :image, styles: { medium: "300x200>", thumb: "60x60>" }

  extend Share::Id2Key
  CleaningTypes = %w(洗车 漆面养护 清洁护理)
  define_id2key_methods :cleaning_type

  def serializable_hash(options={})
    options = { 
      only: [:id, :title, :cleaning_type, :price, :vip_price, :description, :cleaning_orders_count],
      images: [:image],
      include: [:dealer],
    }.update(options)
    super(options)
  end

end