module Tips
  class VipCardOrderEntity < Grape::Entity
    expose :id, :title, :area_id, :area, 
      :price, :vip_price, :description, 
      :orders_count, :reviews_count, :stars
    expose :image, format_with: :image
  end
end
