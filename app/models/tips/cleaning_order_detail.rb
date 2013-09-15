class Tips::CleaningOrderDetail < ActiveRecord::Base
  attr_accessible :count

  validates_presence_of :count

  validates_each :used_count do |record, attr, value|
    record.errors.add(attr, I18n.t('.not_enough_count')) if value && value > count
  end

  def serializable_hash(options={})
    options = { 
      only: [:count, :used_count],
    }.update(options)
    super(options)
  end

end
