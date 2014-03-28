module Statistic
  class SalesCaseEntity < Grape::Entity
    expose :id, :user_mobile, :user_plate_num, :user_brand, :description, :solution, :adviser, :created_at, :state_id, :state
  end
end
