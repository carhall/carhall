module ActionSms
  class SMS
    attr_accessor :to, :body

    def deliver
      ActiveSupport::Notifications.instrument("deliver.action_sms") do |payload|
        set_payload payload
                              
        ihuyi_sms_service_url = "http://106.ihuyi.com/webservice/sms.php?method=Submit&account=cf_qct&password=vRrZz4&mobile=#{to}&content=#{body}"
        begin
          result = Hash.from_xml(open(URI::encode(ihuyi_sms_service_url)).read)
          Rails.logger.info("  Requested Ihuyi API #{ihuyi_sms_service_url}")
          Rails.logger.info("  Result: #{result["SubmitResult"] rescue result}")
          raise result["SubmitResult"]["msg"] unless result["SubmitResult"]["code"] == "2"
        rescue Exception => e
          Rails.logger.info("  Error occurred when delivering SMS: #{e}")
        end
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