module Tips
  class SecondhandAppraiseOrderEntity < Grape::Entity
    expose :id, :title, :state, :cost, :created_at, :order_type, 
      :brand, :series, :plate_num, :purchasing_date, :travelling_miles, 
      :dealer_state, :dealer_state_id
    expose :user, using: Statistic::UserInfoEntity
  end
end
