class Order < ActiveRecord::Base

  # For details
  include Share::Detailable
  alias_method :order_type, :type_sym

  include Tips::Statable
  include Share::Userable

  belongs_to :dealer
  has_one :review

  before_save do
    self.dealer_id = source.dealer_id
    self.title = set_title
  end

  def set_title
    "#{source.title}#{I18n.t(".times", count: detail.count) if detail.respond_to? :count}" 
  end

  extend Share::Id2Key
  States = %i(finished canceled)
  define_id2key_methods :state

  attr_accessible :user, :detail

  def serializable_hash(options={})
    options = { 
      only: [:id, :title],
      methods: [:order_type],
      include: [:detail],
    }.update(options)
    super(options)
  end

end


