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

  def self.rescue_from_with exception_class, status
    rescue_from exception_class do |exception|
      render_error exception.to_s, status
    end
  end
  rescue_from_with ActiveRecord::RecordNotFound, :not_found
  rescue_from_with ActiveModel::MassAssignmentSecurity::Error, :unprocessable_entity
  
  rescue_from_with Exception, :internal_server_error
end