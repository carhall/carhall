module Auth
  module BaseBlock
    extend ActiveSupport::Concern

    included do
      belongs_to :user, class_name: "User"
      belongs_to :blacklist, class_name: "User"

      attr_accessible :blacklist_id, :user_id
    end

  end
end