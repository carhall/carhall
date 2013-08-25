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

    def cancel!
      update_attributes! state_id: States.index("canceled")
    end

    def finish!
      update_attributes! state_id: States.index("finished")
    end
  end
end