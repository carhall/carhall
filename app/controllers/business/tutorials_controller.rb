class Business::TutorialsController < Business::ApplicationController
  set_resource_class Business::Tutorial

  def business_tutorial_params
    params.require(:business_tutorial).permit(:title, :avatar, 
      :file, :url, :product_id, :product_type_id, :distributor_infos)
  end

end