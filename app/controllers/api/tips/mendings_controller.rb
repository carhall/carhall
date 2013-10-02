class Api::Tips::MendingsController < Api::Tips::ApplicationController
  set_resource_class ::Tips::Mending

  def set_parent
    @parent = Tips::Mending.includes(:dealer, :reviews)
  end

  def set_filter
    super
    if params[:filter] and params[:filter][:brand_id]
      @parent = @parent.with_brand(params[:filter][:brand_id].to_i)
    end
  end

  def show
    mending = @dealer.mending if @dealer
    mending ||= Tips::Mending.find(params[:id])
    render_show mending
  end

end
