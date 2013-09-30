class Tips::CleaningsController < Tips::ApplicationController
  set_resource_class Cleaning, orders: true

  def data_params
    params.require(:cleaning).permit(:title, :cleaning_type_id, 
      :price, :vip_price, :description, :image)
  end
  
end
