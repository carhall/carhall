class Api::BaseController < ActionController::Base
  before_filter :authenticate_base_user!

  def self.set_resource_class klass, options = {}
    # GET /api/resources
    # GET /api/resources.json
    define_method :index do
      render_index klass.all
    end

    # GET /api/resources/1
    # GET /api/resources/1.json
    define_method :show do
      render_show klass.find(params[:id])
    end

    # GET /api/resources/1/detail
    # GET /api/resources/1/detail.json
    define_method :detail do
      render_show klass.find(params[:id]).detail_hash
    end if options[:detail]

  end

  def render_index resources
    resources = resources.page(params[:page]) if params[:page]
    resources = resources.per(params[:per_page]) if params[:per_page]
    render json: { data: resources, success: true }
  end

  def render_show resource
    render json: { data: resource, success: true }
  end

  def render_create resource, additional_data = nil
    if resource.save
      render_create_success resource, additional_data
    else
      render_failure resource
    end
  end

  def render_create_success resource, additional_data = nil
    data = { data: resource, success: true }
    data.merge! additional_data if additional_data
    render json: data, status: :created
  end

  def render_update_success resource, additional_data = nil
    data = { data: resource, success: true }
    data.merge! additional_data if additional_data
    render json: data, status: :accepted
  end

  def render_failure resource, status = :unprocessable_entity
    render_errors resource.errors.full_messages, status
  end

  def render_errors errors, status
    render_error errors.first, status
  end

  def render_error error, status
    render json: { error: error, success: false }, status: status
  end

  def render_accepted status = :no_content
    render json: { success: true }, status: status
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
    render_error exception_message, rescue_response
  end
end