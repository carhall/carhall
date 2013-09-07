class BulkPurchasing < ActiveRecord::Base
  belongs_to :dealer
  has_many :bulk_purchasing_orders, as: :source
  alias_attribute :orders, :bulk_purchasing_orders
  has_many :reviews, through: :bulk_purchasing_orders

  has_attached_file :image, styles: { medium: "300x200>", thumb: "60x60>" }

  extend Share::Id2Key
  BulkPurchasingTypes = %w(洗车 漆面养护 清洁护理)
  define_id2key_methods :bulk_purchasing_type

  include Share::Expiredable

  def serializable_hash(options={})
    options = { 
      only: [:id, :title, :expire_at, :bulk_purchasing_type, 
        :price, :vip_price, :description, :bulk_purchasing_orders_count],
      images: [:image],
      include: [:dealer],
    }.update(options)
    super(options)
  end

end