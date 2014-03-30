module Statistic
  class OperatingRecordEntity < Grape::Entity
    expose :id, :project, :operator, :inspector, :adviser, :created_at
    expose :user_info, using: Statistic::UserInfoEntity, as: :user
  end
end