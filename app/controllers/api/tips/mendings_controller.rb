class Api::Tips::MendingsController < Api::Tips::ApplicationController
  set_resource_class Mending
  before_filter :set_filter

  def set_filter
    @parent = @parent.with_brand(params[:filter][:brand_id]) if params[:filter]
  end

end
