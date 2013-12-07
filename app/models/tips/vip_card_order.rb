class Tips::VipCardOrder < Tips::Order
  belongs_to :source, class_name: 'VipCard', counter_cache: :orders_count
  has_many :vip_card_order_items, class_name: 'VipCardOrderItem', autosave: true

  has_many :reviews, foreign_key: :order_id

  def set_title
    source.title
  end

  after_initialize do
    source.vip_card_items.each do |item|
      self.state_id = Category::State[:disabled]
      self.count = 1
      self.vip_card_order_items.new source: item
    end if new_record? rescue nil
  end

  validates_each :state_id do |record, attr, value|
    if record.state_id_was == Category::State[:unfinished] && record.state_id == Category::State[:canceled]
      record.errors.add(:base, I18n.t('order_enabled_can_not_cancel'))
    end
  end


  def to_base_builder
    json = super
    json.items(vip_card_order_items.map{|i|i.to_base_builder.attributes!})
    json
  end

  def create_review item_id, review_params
    item = vip_card_order_items.find(item_id)
    item.has_review = true
    review = reviews.create review_params
    item.save if review.valid?
    review
  end

  def use item_id, count = 1
    raise ArgumentError('negative count') if count < 0
    return if disabled?
    i = vip_card_order_items.find(item_id)
    vip_card_order_items.detect do |item|
      item.use count if item == i
    end
    finish if has_finished?
  end

  def has_finished?
    not vip_card_order_items.detect do |item|
      not item.finished?
    end
  end

end
