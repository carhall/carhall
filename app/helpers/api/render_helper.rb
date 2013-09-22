module Api
  module RenderHelper

    def render_index resources
      resources = Kaminari.paginate_array(resources) if resources.kind_of? Array
      resources = resources.page(params[:page]) if params[:page]
      resources = resources.per(params[:per_page]) if params[:per_page]
      render_data resources.map { |r| r.serializable_hash }
    end

    def render_show resource
      render_data resource.serializable_hash
    end

    def render_data json_data
      render json: { data: json_data, success: true }
    end

    def render_create resource, additional_data={}
      if resource.save
        render_create_success resource, additional_data
      else
        render_failure resource
      end
    end

    def render_update resource, additional_data={}
      if resource.save
        render_update_success resource, additional_data
      else
        render_failure resource
      end
    end

    def render_create_success resource, additional_data={}
      json_data = resource.serializable_hash.merge additional_data
      render json: { data: json_data, success: true }, status: :created
    end

    def render_update_success resource, additional_data={}
      json_data = resource.serializable_hash.merge additional_data
      render json: { data: json_data, success: true }, status: :accepted
    end

    def render_failure resource, status = :unprocessable_entity
      render_errors resource.errors.full_messages, status
    end

    def render_errors errors, status, additional_data={}
      render_error errors.first, status, additional_data
    end

    def render_error error, status, additional_data={}
      json = { error: error, error_code: status, success: false }
      render json: json.merge(additional_data), status: status
    end

    def render_ok status = :ok
      render json: { success: true }, status: status
    end

    def render_accepted
      render_ok :accepted
    end

    def render_created
      render_ok :created
    end
  end
end