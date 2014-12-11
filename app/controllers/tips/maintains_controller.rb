class Tips::MaintainsController < Tips::ApplicationController
  set_resource_class Tips::Maintain, orders: true

  def tips_cleaning_params
    params.require(:tips_maintain).permit(:title, :maintain_type_id, 
      :price, :vip_price, :description, :image)
  end

  def cheyouhui_new
  	@cleaning = Tips::Maintain.new
  end
  
end
