module Statistic
  class SalesCaseEntity < Grape::Entity
    expose :id, :description, :solution, :adviser, :created_at, :state_id, :state
    expose :user_info, using: Statistic::UserInfoEntity, as: :user
  end
end
