class Tips::MendingsController < Tips::ApplicationController
  set_resource_class Tips::Mending, singleton: true, through: :dealer, orders: true

  alias_method :edit_discount, :edit
  alias_method :edit_brands, :edit

  def update
    @tip = @parent || Tips::Mending.new(dealer: @dealer)

    if @tip.update_attributes(data_params)
      index_path = { action: :index }
      redirect_to tips_root_path, flash: { success: i18n_message(:update_success_without_title, 'tips/mending') }
    else
      if params[:commit] == "更新专修品牌"
        render :edit_brands
      elsif params[:commit] == "更新预约优惠信息"
        render :edit_discount
      end
    end
  end

  def tips_mending_params
    params.require(:tips_mending).permit(
      discount:[:discount_during, :man_hours_discount, :spare_parts_discount], 
      brand_ids: []
    )
  end
  
end
