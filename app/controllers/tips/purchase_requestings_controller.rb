class Tips::PurchaseRequestingsController < Tips::ApplicationController
  set_resource_class ::Tips::PurchaseRequesting, expiredable: true

  def tips_purchase_requesting_params
    params.require(:tips_purchase_requesting).permit(:title, :purchase_requesting_type_id, 
      :expire_at, :price_range, :description, :image)
  end

end
