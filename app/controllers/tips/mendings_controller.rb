class Tips::MendingsController < Tips::ApplicationController
  set_resource_class Tips::Mending, orders: true

  def edit
    load_mending
  end

  alias_method :edit_discount, :edit
  alias_method :edit_brands, :edit

  def update
    load_mending

    if @mending.update_attributes(tips_mending_params)
      flash[:success] = i18n_message(:update_success_without_title)
      redirect_to tips_root_path
    else
      if params[:commit] == "更新专修品牌"
        render :edit_brands
      elsif params[:commit] == "更新预约优惠信息"
        render :edit_discount
      end
    end
  end

  def tips_mending_params
    discount = [:discount_during, :man_hours_discount, :spare_parts_discount]
    params.require(:tips_mending).permit(
      discount: [monday: discount, tuesday: discount, 
        wednesday: discount, thursday: discount, friday: discount, 
        saturday: discount, sunday: discount], 
      brand_ids: []
    )
  end

  def load_mending
    if @dealer
      @mending = @dealer.mending || @dealer.build_mending
    else
      @mending = Tips::Mending.find(params[:id])
    end
  end
  
end
