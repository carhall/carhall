module Share
  module Statable
    extend ActiveSupport::Concern
      
    extend Share::Id2Key
    States = %i(finished canceled)
    define_id2key_methods :state

    included do
      validates_each :state_id do |record, attr, value|
        if record.state_id_was == States.index(:canceled)
          record.errors.add(attr, I18n.t('order_canceled'))
        end
      end
    end

    def cancel
      self.state = :canceled
    end

    def finish
      self.state = :finished
    end

    def canceled?
      self.state == :canceled
    end

    def finished?
      self.state == :finished
    end

    def reset
      self.state_id = nil
    end

    def self.get_id state
      if state.kind_of? Integer then state else States.index state end
    end

    extend Share::Exclamation
    define_exclamation_and_method :cancel
    define_exclamation_and_method :finish
    define_exclamation_and_method :reset

  end
end