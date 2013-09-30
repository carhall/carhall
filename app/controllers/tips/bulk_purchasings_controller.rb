class Tips::BulkPurchasingsController < Tips::ApplicationController
  set_resource_class BulkPurchasing, orders: true, expiredable: true

  def data_params
    params.require(:bulk_purchasing).permit(:title, :bulk_purchasing_type_id, 
      :expire_at, :price, :vip_price, :description, :image)
  end

end
