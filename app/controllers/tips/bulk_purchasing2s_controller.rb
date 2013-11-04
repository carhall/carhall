class Tips::BulkPurchasing2sController < Tips::ApplicationController
  set_resource_class Tips::BulkPurchasing2, orders: true, expiredable: true

  def tips_bulk_purchasing2_params
    params.require(:tips_bulk_purchasing2).permit(:title, :bulk_purchasing_type_id, 
      :expire_at, :price, :vip_price, :inventory, :description, :image)
  end

end
