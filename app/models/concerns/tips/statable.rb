module Tips::Statable
  extend ActiveSupport::Concern

  included do
    validates_each :state_id do |record, attr, value|
      if record.state_id_was == Category::State[:canceled]
        record.errors.add(attr, I18n.t('order_canceled'))
      end
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

  def canceled?
    self.state_id == Category::State[:canceled]
  end

  def finished?
    self.state_id == Category::State[:finished]
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
  define_exclamation_and_method :cancel
  define_exclamation_and_method :finish
  define_exclamation_and_method :reset

end
