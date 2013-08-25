module Auth
  class Friendship < ActiveRecord::Base
    belongs_to :user, class_name: "BaseUser"
    belongs_to :friend, class_name: "BaseUser"

    attr_accessible :friend_id, :user_id

  end
end
