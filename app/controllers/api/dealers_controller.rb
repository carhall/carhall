class Api::DealersController < Api::ApplicationController
  set_resource_class Dealer, detail: true
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
    if filter = params[:filter]
      @parent = @parent.with_dealer_type(filter[:dealer_type_id].to_i) if filter[:dealer_type_id]
      @parent = @parent.with_business_scope(filter[:business_scope_id].to_i) if filter[:business_scope_id]
    end
  end

end
