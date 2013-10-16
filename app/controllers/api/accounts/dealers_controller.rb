class Api::Accounts::DealersController < Api::Accounts::ApplicationController
  set_resource_class ::Accounts::Dealer, detail: true, display: true
  before_filter :search_parent
  before_filter :set_filter

  def nearby
    render_index @parent.with_location params[:lat].to_f, params[:lng].to_f
  end
    
  def favorite
    render_index @parent.favorite
  end
    
  def hot
    render_index @parent.hot
  end

  def set_filter
    filter_parent :area
    filter_parent :dealer_type
    filter_parent :business_scope
    filter_parent :specific_service
  end

end