class Cleaning < ActiveRecord::Base
  belongs_to :dealer
  has_many :cleaning_orders, as: :source
  alias_attribute :orders, :cleaning_orders
  has_many :reviews, through: :cleaning_orders

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }

  def serializable_hash(options={})
    options = { 
      only: [:id, :title, :typehood, :price, :vip_price, :description, :cleaning_orders_count],
      methods: [:image],
      include: [:dealer],
    }.update(options)
    super(options)
  end

end