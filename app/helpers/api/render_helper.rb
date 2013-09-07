module Api
  module RenderHelper
    def render_index resources
      resources = resources.page(params[:page]) if params[:page]
      resources = resources.per(params[:per_page]) if params[:per_page]
      render json: { data: resources.serializable_hash(request: request), success: true }
    end

    def render_show resource
      render json: { data: resource.serializable_hash(request: request), success: true }
    end

    def render_create resource, additional_data = nil
      if resource.save
        render_create_success resource, additional_data
      else
        render_failure resource
      end
    end

    def render_create_success resource, additional_data = nil
      json = { data: resource.serializable_hash(request: request), success: true }
      json.merge! additional_data if additional_data
      render json: json, status: :created
    end

    def render_update_success resource, additional_data = nil
      json = { data: resource.serializable_hash(request: request), success: true }
      json.merge! additional_data if additional_data
      render json: json, status: :accepted
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

    def render_accepted status = :accepted
      render json: { success: true }, status: status
    end
  end
end