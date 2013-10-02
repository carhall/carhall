class Api::Accounts::DealersController < Api::Accounts::ApplicationController
  set_resource_class ::Accounts::Dealer, detail: true
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
    if params[:filter] and params[:filter][:area_id]
      @parent = @parent.with_area(params[:filter][:area_id].to_i)
    end
    if params[:filter] and params[:filter][:dealer_type_id]
      @parent = @parent.with_dealer_type(params[:filter][:dealer_type_id].to_i)
    end
    if params[:filter] and params[:filter][:business_scope_id]
      @parent = @parent.with_business_scope(params[:filter][:business_scope_id].to_i)
    end
  end

end
