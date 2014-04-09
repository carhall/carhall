module Tips
  class TestDriveOrderEntity < Grape::Entity
    expose :id, :title, :state, :cost, :created_at, :order_type, 
      :dealer_state, :dealer_state_id
    expose :user, using: Statistic::UserInfoEntity
  end
end
