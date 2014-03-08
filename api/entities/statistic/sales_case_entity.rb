module Statistic
  class SalesCaseEntity < Grape::Entity
    expose :id, :description, :solution, :adviser, :created_at, :state_id, :state
  end
end
