module Share
  module Userable
    extend ActiveSupport::Concern
      
    included do
      default_scope { includes(:user) }
      belongs_to :user, class_name: 'BaseUser'
    end

    module ClassMethods
      def with_user user_id
        where user_id: user_id
      end

      def first_user
        User.where(id: first && first.user_id).first
      end
      
      def all_users
        User.where(id: pluck(:user_id))
      end
    end

  end
end