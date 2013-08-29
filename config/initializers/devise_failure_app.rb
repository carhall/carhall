module Devise
  FailureApp.class_eval do

    def http_auth_body
      return i18n_message unless request_format
      method = "to_#{request_format}"
      if method == "to_xml"
        { :error => i18n_message }.to_xml(:root => "errors")
      elsif method == "to_json"
        { :errors => [ i18n_message ], :success => false }.to_json
      elsif {}.respond_to?(method)
        { :error => i18n_message }.send(method)
      else
        i18n_message
      end
    end
    
  end
end