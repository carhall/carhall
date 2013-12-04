module Tips::Statable
  extend ActiveSupport::Concern

  included do
    validates_each :state_id do |record, attr, value|
      if record.canceled?
        record.errors.add(:base, I18n.t('order_canceled'))
      end
      if record.disabled?
        record.errors.add(:base, I18n.t('order_disabled'))
      end
    end

    validates_each :used_count do |record, attr, value|
      count = record.count
      record.errors.add(:base, I18n.t('.not_enough_count')) if value && count && value > count
    end

    enumerate :state, with: Category::State

  end

  def cancel
    self.state = :canceled
  end

  def finish
    self.state = :finished
  end

  def reset
    self.state = :unfinished
  end

  def disable
    self.state = :disabled
  end

  alias_method :enable, :reset

  def canceled?
    self.state_id == Category::State[:canceled] or self.state_id_was == Category::State[:canceled]
  end

  def finished?
    self.state_id == Category::State[:finished]
  end

  def disabled?
    self.state_id == Category::State[:disabled] and self.state_id_was == Category::State[:disabled]
  end

  def use count = 1
    raise ArgumentError('negative count') if count < 0
    self.used_count ||= 0
    self.used_count += count
    finish if self.used_count >= self.count
  end

  def used?
    self.used_count.nil? or self.used_count == 0
  end


  extend Share::Exclamation
  define_exclamation_and_method :cancel
  define_exclamation_and_method :finish
  define_exclamation_and_method :use
  define_exclamation_and_method :reset
  define_exclamation_and_method :enable
  define_exclamation_and_method :disable

end
