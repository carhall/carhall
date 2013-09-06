module ActionSms
  class LogSubscriber < ActiveSupport::LogSubscriber
    def deliver(event)
      p 'logger'
      return unless logger.info?
      recipients = Array(event.payload[:to]).join(', ')
      info("\nSent SMS to #{recipients} (#{event.duration.round(1)}ms)")
      debug(event.payload[:sms])
    end

    def logger
      ActionSms::Base.logger
    end
  end
end

ActionSms::LogSubscriber.attach_to :action_sms
