module Statistic
  class OperatingRecordEntity < Grape::Entity
    expose :id, :user_plate_num, :project, :operator, :inspector, :adviser, :created_at
  end
end