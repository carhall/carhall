class Business::AdvertsController < Business::ApplicationController
  set_resource_class Business::Advert, title: :advert_type

  def business_advert_params
    params.require(:business_advert).permit(:image, :advert_type_id, :area_id, :brand_id)
  end

end