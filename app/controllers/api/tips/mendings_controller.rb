class Api::Tips::MendingsController < Api::Tips::ApplicationController
  set_resource_class Tips::Mending
  before_filter :set_filter

  def set_parent
    @parent = Tips::Mending.includes(:dealer, :reviews)
  end

  def set_filter
    @parent = @parent.with_brand(params[:filter][:brand_id]) if params[:filter]
  end

  def show
    mending = @dealer.mending if @dealer
    mending ||= Tips::Mending.find(params[:id])
    render_show mending
  end

end
