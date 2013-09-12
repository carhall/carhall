class CleaningOrder < Order
  set_detail_class Tips::CleaningOrderDetail
  belongs_to :source, class_name: Cleaning, counter_cache: :orders_count

  def use count = 1
    raise ArgumentError('negative count') if count < 0
    detail.used_count ||= 0
    detail.used_count += count
    finish if detail.used_count == detail.count
  end

  def used?
    detail.used_count.nil? or detail.used_count == 0
  end

  extend Share::Exclamation
  define_exclamation_and_method :use

end
