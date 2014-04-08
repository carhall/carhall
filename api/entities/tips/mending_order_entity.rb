module Tips
  class MendingOrderEntity < Grape::Entity
    expose :id, :arrive_at, :state, :cost, 
      :created_at, :order_type, :dealer_id,
      :arrive_at, :brand, :series, :plate_num,
      :dealer_state, :dealer_state_id
    expose :user, using: Statistic::UserInfoEntity
    with_options if: { type: :detail } do
      expose :mending_type
    end
  end
end
