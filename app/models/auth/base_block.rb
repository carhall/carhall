module Auth
  module BaseBlock
    extend ActiveSupport::Concern

    included do
      belongs_to :user, class_name: "BaseUser"
      belongs_to :blacklist, class_name: "BaseUser"

      attr_accessible :blacklist_id, :user_id
    end

  end
end