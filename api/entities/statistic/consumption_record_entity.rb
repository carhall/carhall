module Statistic
  class ConsumptionRecordEntity < Grape::Entity
    expose :id, :title, :count, :created_at
    expose :user, using: Statistic::UserInfoEntity, as: :user
  end
end