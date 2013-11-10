class Tips::BulkPurchasing2Order < ActiveRecord::Base
  include Tips::Statable

  belongs_to :dealer, class_name: 'Accounts::Account'
  belongs_to :distributor, counter_cache: :orders_count, class_name: 'Accounts::Distributor'

  belongs_to :source, counter_cache: :orders_count, class_name: 'BulkPurchasing2'

  validates_presence_of :count
  
  validates_each :used_count do |record, attr, value|
    if record.used_count_changed? && value && value > count 
      record.errors.add(attr, I18n.t('.not_enough_count'))
    end
  end
  
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
