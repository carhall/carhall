class Tips::VipCardOrderItem < ActiveRecord::Base
  include Tips::Statable
  
  belongs_to :source, class_name: 'VipCardItem'
  belongs_to :vip_card_order, class_name: 'VipCardOrder'

  before_create do
    self.count = set_count
    self.title = set_title
    # self.cost = set_cost
  end

  def set_title
    source.title 
  end

  def set_count
    source.count
  end

  def set_cost
    cost = source.price if source.respond_to? :price
    cost *= count if count
  end

  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :title, :state_id, :state, :count, :used_count, :has_review
    end
  end

end
