class Api::ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  include ActionController::StrongParameters

  # This is our new function that comes before Devise's one
  before_filter :authenticate_account_from_token!
  # This is Devise's authentication
  # before_filter :authenticate_account!

  include Api::RenderHelper
  include FilterHelper
  alias_method :current_user, :current_account

  def self.set_resource_class klass, options = {}
    before_filter :set_parent

    define_method :set_parent do
      @parent = klass.all
    end
    
    # GET /api/resources
    # GET /api/resources.json
    define_method :index do
      render_index @parent
    end

    # GET /api/resources/1
    # GET /api/resources/1.json
    define_method :show do
      render_show @parent.find(params[:id])
    end

    # GET /api/resources/1
    # GET /api/resources/1.json
    define_method :detail do
      render_show @parent.find(params[:id]), :detail
    end if options[:detail]
    
  end

  rescue_from Exception do |exception|
    exception_message = exception.message
    exception_name = exception.class.name
    rescue_response = ActionDispatch::ExceptionWrapper.rescue_responses[exception_name]
    exception_message = I18n.t "#{exception_name.underscore}", 
      default: I18n.t(:description, default: exception_message),
      scope: [:exception, rescue_response], 
      exception_name: exception_name, 
      exception_message: exception_message
    render_error exception_message, rescue_response, {
      error_code: exception_name.demodulize.underscore, 
      backtrace: exception.backtrace[0..2],
    }
    Rails.logger.error <<-EOE
API Error: #{exception_name}: #{exception_message}
  #{exception.backtrace.select{|b|b=~/carhall/}.join("\n  ")}
EOE
  end

private
  
  # For this example, we are simply using token authentication
  # via parameters. However, anyone could use Rails's token
  # authentication features to get the token from a header.
  def authenticate_account_from_token!
    auth_token = params[:auth_token].presence
    @current_account = Rails.cache.fetch([:auth_token, auth_token], expires_in: 1.hour) do
      auth_token && ::Accounts::Account.find_by(authentication_token: auth_token)
    end

    if @current_account
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in @current_account, store: false
    else
      authenticate_account!
    end
  end
end