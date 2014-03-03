class AssistantAPI < Grape::API
  version 'v1', using: :param
  format :json
  helpers GrapeHelper

  error_formatter :json, ErrorFormatter
  formatter :json, DataFormatter

  # rescue_from :all do |exception|
  #   status_code = ActionDispatch::ExceptionWrapper.new(env, exception).status_code
  #   error = "#{status_code} #{exception.class.name.demodulize.titleize}"
  #   Rack::Response.new({
  #     error: error,
  #     success: false
  #   }.to_json, status_code)
  # end

  helpers do
    def current_user
      token = params[:token].presence
      Rails.cache.fetch([:current_user, :token, token], expires_in: 1.hour) do
        Accounts::Account.find_by(authentication_token: token) rescue nil
      end
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end
  end

  mount Accounts::LoginAPI
  mount Accounts::CurrentUserAPI => '/current_user'
  mount Tips::VipCardOrderAPI => '/vip_card_orders'

end
