class Order < ActiveRecord::Base
  # For details
  include Share::Detailable
  alias_method :order_type, :type_sym

  include Share::Statable
  include Share::Userable

  belongs_to :dealer
  has_one :review

  attr_accessible :user, :detail
  attr_accessible :detail_attributes

  validates_presence_of :source, :user 
  
  before_create do
    self.dealer_id = source.dealer_id
    self.title = set_title
    self.cost = set_cost
  end

  def set_title
    "#{source.title}#{I18n.t(".times", count: detail.count) if detail.respond_to? :count}" 
  end

  def set_cost
    cost = source.price if source.respond_to? :price
    cost *= detail.count if detail.respond_to? :count
  end

  extend Share::Id2Key
  States = %i(finished canceled)
  define_id2key_methods :state

  def serializable_hash(options={})
    options = { 
      only: [:id, :title],
      methods: [:order_type],
      include: [:detail],
    }.update(options)
    super(options)
  end

end
