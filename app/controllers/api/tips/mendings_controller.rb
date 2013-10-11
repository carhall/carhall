class Api::Tips::MendingsController < Api::Tips::ApplicationController
  set_resource_class ::Tips::Mending

  def set_parent
    @parent = ::Tips::Mending.includes(:dealer, :reviews).ordered
  end

  def set_filter
    super
    filter_parent :brand
  end

  def show
    mending = ::Tips::Mending.find(params[:id]) if params[:id]
    mending = @dealer.mending if @dealer
    render_show mending
  end

end
