module ActionSms
  class SMS
    attr_accessor :to, :body

    def deliver
      ActiveSupport::Notifications.instrument("deliver.action_sms") do |payload|
        set_payload payload

        puts self.body
      end
    end

    def set_payload(payload)
      payload[:to] = to
      payload[:body] = body
      payload[:sms] = self
    end
  end

  class NullSMS < SMS
  end

end