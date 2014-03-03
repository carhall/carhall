module Tips
class VipCardOrderItemEntity < Grape::Entity
    expose :id, :title, :state_id, :state, :count, :used_count, :has_review
  end
end
