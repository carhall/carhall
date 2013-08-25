module Share
  module Userable
    extend ActiveSupport::Concern
      
    included do
      default_scope { includes(:user) }
      belongs_to :user, class_name: 'BaseUser'
    end

    module ClassMethods
      def user user_id
        where user_id: user_id
      end
    end

  end
end