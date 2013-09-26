class Api::ApplicationController < ActionController::Base
  before_filter :authenticate_account!

  include Api::RenderHelper
  include FilterHelper

  def self.set_resource_class klass, options = {}
    before_filter :set_parent

    define_method :set_parent do
      @parent = klass
    end
    
    # GET /api/resources
    # GET /api/resources.json
    define_method :index do
      render_index @parent.scoped
    end

    # GET /api/resources/1
    # GET /api/resources/1.json
    define_method :show do
      render_show @parent.find(params[:id])
    end

    # GET /api/resources/1
    # GET /api/resources/1.json
    define_method :detail do
      render_data @parent.find(params[:id]).detail_hash
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
  end
end