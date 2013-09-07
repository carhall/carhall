class BaseOrder < ActiveRecord::Base

  # For details
  include Share::Detailable
  alias_method :order_type, :detail_type_sym

  include Tips::Statable
  include Share::Userable

  belongs_to :source, polymorphic: true, counter_cache: true
  belongs_to :dealer
  belongs_to :review

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

  validates_presence_of :source

  attr_accessible :user, :detail

  def serializable_hash(options={})
    options = { 
      only: [:id],
      methods: [:order_type],
      include: [:detail],
    }.update(options)
    super(options)
  end

end


