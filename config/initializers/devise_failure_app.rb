module Devise
  FailureApp.class_eval do

    def respond
      if env["REQUEST_PATH"] =~ /^\/api/
        respond_json
      elsif http_auth?
        http_auth
      elsif warden_options[:recall]
        recall
      else
        redirect
      end
    end

    def http_auth_body
      return i18n_message unless request_format
      method = "to_#{request_format}"
      if method == "to_xml"
        { error: i18n_message }.to_xml(root: "errors")
      elsif method == "to_json"
        { error: i18n_message, error_code: warden_message, success: false }.to_json
      elsif {}.respond_to?(method)
        { error: i18n_message }.send(method)
      else
        i18n_message
      end
    end

    def respond_json
      self.status = 401
      self.headers["WWW-Authenticate"] = %(Basic realm=#{Devise.http_authentication_realm.inspect}) if http_auth_header?
      self.content_type = 'application/json'
      self.response_body = { error: i18n_message, error_code: warden_message, success: false }.to_json
    end
  end
end