class Tips::CleaningOrder < Tips::Order
  belongs_to :source, class_name: 'Cleaning', counter_cache: :orders_count

  validates_presence_of :count

  validates_each :used_count do |record, attr, value|
    record.errors.add(attr, I18n.t('.not_enough_count')) if value && value > count
  end

  def use count = 1
    raise ArgumentError('negative count') if count < 0
    self.used_count ||= 0
    self.used_count += count
    finish if self.used_count == self.count
  end

  def used?
    self.used_count.nil? or self.used_count == 0
  end

  extend Share::Exclamation
  define_exclamation_and_method :use

  api_accessible :base, extend: :base do |t|
    t.add :count
    t.add :used_count
  end
  
end
