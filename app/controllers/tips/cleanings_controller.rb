class Tips::CleaningsController < Tips::ApplicationController
  set_resource_class Tips::Cleaning, orders: true

  def tips_cleaning_params
    params.require(:tips_cleaning).permit(:title, :cleaning_type_id, 
      :price, :vip_price, :description, :image,:is_cheyouhui)
  end

  def cheyouhui_new
  	@cleaning = Tips::Cleaning.new
  end
  
end
