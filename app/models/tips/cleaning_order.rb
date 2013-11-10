class Tips::CleaningOrder < Tips::Order
  belongs_to :source, class_name: 'Cleaning', counter_cache: :orders_count

  validates_presence_of :count

  validates_each :used_count do |record, attr, value|
    if record.used_count_changed? && value && value > count 
      record.errors.add(attr, I18n.t('.not_enough_count'))
    end
  end

  extend Share::Exclamation
  define_exclamation_and_method :use

  def to_base_builder
    json = super
    json.extract! self, :count, :used_count
    json
  end

end
