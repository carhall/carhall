class Tips::CleaningOrder < Tips::Order
  belongs_to :source, class_name: 'Cleaning', counter_cache: :orders_count

  validates_presence_of :count

  extend Share::Exclamation
  define_exclamation_and_method :use

  def to_base_builder
    json = super
    json.extract! self, :count, :used_count
    json
  end

end
