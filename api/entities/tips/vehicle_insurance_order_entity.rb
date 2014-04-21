module Tips
  class VehicleInsuranceOrderEntity < Grape::Entity
    expose :id, :title, :state, :cost, :created_at, :order_type, 
      :brand, :series, :plate_num, :insurance_type, :insurance_type_id,
      :dealer_state, :dealer_state_id
    expose :user, using: Statistic::UserInfoEntity
  end
end
