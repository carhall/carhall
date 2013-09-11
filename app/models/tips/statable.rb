module Tips
  module Statable
    extend ActiveSupport::Concern
      
    States = %(finished canceled)

    def state
      return I18n.t('.unknown') unless state_id
      States[state_id]
    end

    def state= state
      self.state_id = States.index state
    end

    def cancel
      self.state_id = States.index("canceled")
    end

    def finish
      self.state_id = States.index("finished")
    end

    def cancel!
      cancel && save(validate: false)
    end

    def finish!
      finish && save(validate: false)
    end
  end
end