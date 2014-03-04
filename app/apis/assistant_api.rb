class AssistantAPI < Grape::API
  version 'v1', using: :param
  format :json
  helpers GrapeHelper

  error_formatter :json, ErrorFormatter
  formatter :json, DataFormatter

  rescue_from :all do |exception|
    status_code = ActionDispatch::ExceptionWrapper.new(env, exception).status_code
    error = "#{status_code} #{exception.class.name.demodulize.titleize}: #{exception.message}"
    Rack::Response.new({
      error: error,
      success: false
    }.to_json, status_code)
  end

  mount Accounts::LoginAPI
  mount Accounts::CurrentUserAPI => '/current_user'
  mount Tips::VipCardOrderAPI => '/vip_card_orders'
  mount Statistic::OperatingRecordAPI => '/operating_records'

end
