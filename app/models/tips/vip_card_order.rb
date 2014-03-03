class Tips::VipCardOrder < Tips::Order
  belongs_to :source, class_name: 'VipCard', counter_cache: :orders_count

  has_many :vip_card_order_items, class_name: 'VipCardOrderItem', autosave: true
  accepts_nested_attributes_for :vip_card_order_items, allow_destroy: false, update_only: true
  alias_attribute :items, :vip_card_order_items
  alias_attribute :item_attributes, :vip_card_order_item_attributes

  has_many :reviews, foreign_key: :order_id

  def set_title
    source.title
  end

  after_initialize do
    source.items.each do |item|
      self.state_id = Category::State[:disabled]
      self.count = 1
      self.items.new source: item
    end if new_record? rescue nil
  end

  validates_each :state_id do |record, attr, value|
    if record.state_id_was == Category::State[:unfinished] && record.state_id == Category::State[:canceled]
      record.errors.add(:base, I18n.t('order_enabled_can_not_cancel'))
    end
  end

  def to_base_builder
    json = super
    json.items(items.map{|i|i.to_base_builder.attributes!})
    json
  end

  def build_review item_id, review_params={}
    item = items.find(item_id)
    review = reviews.new review_params
    if item.has_review
      raise ActiveRecord::RecordNotSaved.new("Failed to remove the existing associated review.")
    else
      item.has_review = true
      item.save if review.valid?
    end
    review
  end

  def use item_id, count = 1
    raise ArgumentError('negative count') if count < 0
    return if disabled?
    items.detect do |item|
      item.use count if item.id == item_id
    end
    finish if has_finished?
  end

  def has_finished?
    not vip_card_order_items.detect do |item|
      not item.finished?
    end
  end

end
