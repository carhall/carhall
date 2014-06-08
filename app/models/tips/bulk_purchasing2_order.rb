class Tips::BulkPurchasing2Order < ActiveRecord::Base
  include Tips::Statable

  include Share::Dealerable
  include Share::Distributorable

  delegate :mobile, :username, to: :dealer, prefix: true
  
  belongs_to :source, counter_cache: :orders_count, class_name: 'BulkPurchasing2'

  validates_presence_of :count, :dealer
  
  before_create do
    self.distributor_id = source.distributor_id
    self.title = set_title
    self.cost = set_cost
  end

  def set_title
    "#{source.title}#{I18n.t(".times", count: count) if count}" 
  end

  def set_cost
    cost = source.vip_price if source.respond_to? :vip_price
    cost *= count if count
  end

end
