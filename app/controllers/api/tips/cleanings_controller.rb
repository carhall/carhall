class Api::Tips::CleaningsController < Api::Tips::ApplicationController
  set_resource_class ::Tips::Cleaning

  def set_filter
    super
    if params[:filter]
      if params[:filter][:cleaning_type_id]
        @parent = @parent.with_cleaning_type(params[:filter][:cleaning_type_id].to_i)
      end
      if params[:filter][:cleaning_type]
        @parent = @parent.with_cleaning_type(params[:filter][:cleaning_type])
      end
    end
  end

end
