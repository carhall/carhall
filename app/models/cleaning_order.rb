class CleaningOrder < BaseOrder
  set_detail_class Tips::CleaningOrderDetail

  def use count = 1
    detail.count ||= 0
    detail.used_count ||= 0
    if detail.used_count + count > detail.count
      errors.add(:detail, I18n.t('.not_enough_count'))
    else
      detail.increment!(:used_count, count)
      finish if detail.used_count == detail.count
    end
  end

  def use! count = 1
    use(count) && save(validate: false)
  end

end
