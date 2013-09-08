module Share
  module Userable
    extend ActiveSupport::Concern
      
    included do
      default_scope { includes(:user) }
      belongs_to :user, class_name: 'BaseUser'
    end

    module ClassMethods
      def with_user user
        user = user.id if user.kind_of? BaseUser
        where user_id: user
      end

    end

  end
end