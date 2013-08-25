class CleaningOrder < BaseOrder
  set_detail_class Tips::CleaningOrderInfo

  belongs_to :source, class_name: 'Cleaning', counter_cache: true

  def use! count = 1
    if detail.used_count + count > detail.count
      self.errors.add(:detail, I18n.t('.not_enough_count'))
    else
      detail.increment!(:used_count, count)
      finished! if detail.used_count == detail.count
    end
  end

end
