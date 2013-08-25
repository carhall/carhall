class BulkPurchasing < ActiveRecord::Base
  belongs_to :dealer
  has_many :bulk_purchasing_orders, as: :source
  alias_attribute :orders, :bulk_purchasing_orders
  has_many :reviews, through: :bulk_purchasing_orders

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }

  def serializable_hash(options={})
    options = { 
      only: [:id, :title, :expire_at, :typehood, 
        :price, :vip_price, :description, :bulk_purchasing_orders_count],
      methods: [:image],
      include: [:dealer],
    }.update(options)
    super(options)
  end

end