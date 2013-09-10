class CleaningOrder < BaseOrder
  set_detail_class Tips::CleaningOrderDetail

  def use! count = 1
    if detail.used_count + count > detail.count
      self.errors.add(:detail, I18n.t('.not_enough_count'))
    else
      detail.increment!(:used_count, count)
      finished! if detail.used_count == detail.count
    end
  end

end
