module Share
  module Userable
    extend ActiveSupport::Concern
      
    included do
      default_scope { includes(:user) }
      belongs_to :user, class_name: 'BaseUser'
    end

    def self.get_id user
      if user.kind_of? BaseUser then user.id else user end
    end

    module ClassMethods
      def with_user user
        user_id = Userable.get_id user
        where user_id: user
      end

    end

  end
end