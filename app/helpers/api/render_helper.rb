module Api
  module RenderHelper

    def render_index resources, api_template=:base
      resources = Kaminari.paginate_array(resources) if resources.kind_of? Array
      resources = resources.page(params[:page]) if params[:page]
      resources = resources.per(params[:per_page]) if params[:per_page]
      render_data resources.as_api_response api_template
    end

    def render_show resource, api_template=:base
      render_data resource.as_api_response api_template
    end

    def render_data json_data, status=:ok
      render json: { data: json_data, success: true }, status: status
    end

    def render_create resource, api_template=:base
      if resource.save
        render_create_success resource, api_template
      else
        render_failure resource
      end
    end

    def render_update resource, api_template=:base
      if resource.save
        render_update_success resource, api_template
      else
        render_failure resource
      end
    end

    def render_create_success resource, api_template=:base
      render_data resource.as_api_response(api_template), :created
    end

    def render_update_success resource, api_template=:base
      render_data resource.as_api_response(api_template), :accepted
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