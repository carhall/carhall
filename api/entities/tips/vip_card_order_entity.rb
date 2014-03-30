module Tips
  class VipCardOrderEntity < Grape::Entity
    expose :id, :title, :state_id, :state, :cost, 
      :created_at, :order_type, :dealer_id
    expose :user, using: Statistic::UserInfoEntity
    with_options if: { type: :detail } do
      expose :items, using: Tips::VipCardOrderItemEntity
    end
  end
end
