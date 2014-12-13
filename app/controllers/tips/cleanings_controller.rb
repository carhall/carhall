class Tips::CleaningsController < Tips::ApplicationController
  set_resource_class Tips::Cleaning, orders: true

  def index

  	@cleanings = @user.cleanings
    @cleanings = @cleanings.where("is_cheyouhui"=>true,cleaning_type_id: 1) if params["is_cheyouhui"]=="1" && params["type"]=="cleaning"
    @cleanings = @cleanings.where("is_cheyouhui"=>true,cleaning_type_id: 5) if params["is_cheyouhui"]=="1" && params["type"]=="mending"
 
  end

  def tips_cleaning_params
    params.require(:tips_cleaning).permit(:title, :cleaning_type_id, 
      :price, :vip_price, :description, :image,:is_cheyouhui)
  end

  def cheyouhui_new
  	@cleaning = Tips::Cleaning.new
  end
  
end
