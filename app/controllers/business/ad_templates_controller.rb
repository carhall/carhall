class Business::AdTemplatesController < Business::ApplicationController
  set_resource_class Business::AdTemplate

  def business_ad_template_params
    params.require(:business_ad_template).permit(:title, :avatar, 
      :file, :product_id, :product_type_id, :price)
  end

end