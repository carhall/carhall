class Api::Tips::CleaningsController < Api::Tips::ApplicationController
  set_resource_class Tips::Cleaning
  before_filter :set_filter

  def set_filter
    @parent = @parent.with_cleaning_type(params[:filter][:cleaning_type_id].to_i) if params[:filter]
  end

end
