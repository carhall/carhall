class Tips::MendingsController < Tips::ApplicationController
  set_resource_class Mending, singleton: true, orders: true

  alias_method :edit_discount, :edit
  alias_method :edit_brands, :edit

  def data_params
    params.require(:mending).permit(
      discount:[:discount_during, :man_hours_discount, :spare_parts_discount], 
      brand_ids: []
    )
  end
  
end
