class Api::Tips::CleaningsController < Api::Tips::ApplicationController
  set_resource_class Cleaning
  before_filter :set_filter

  def set_filter
    @parent = @parent.where(params[:filter].slice(:cleaning_type_id)) if params[:filter]
  end

end
