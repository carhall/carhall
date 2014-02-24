module Entities
  module Accounts
    module AccountEntity
      def self.user_type_id user
        { guest: 1, admin: 2, user: 3, dealer: 4, provider: 5, 
          distributor: 6, agent: 7 }[user.user_type]
      end

      def self.avatar_thumb_url avatar
        "#{AbsoluteUrlPrefix}#{avatar.url(:thumb, timestamp: false)}" if avatar.present?
      end

      class OpenfireUserInfo < Grape::Entity        
        expose :id, :mobile
        expose :user_type_id do |user, options|
          AccountEntity.user_type_id user
        end
        expose :authentication_token, as: :token
      end

      class OpenfireUserDetail < Grape::Entity
        expose :id, :username, :mobile
        expose :sex_id do |user, options|
          user.sex_id || 0
        end 
        expose :user_type_id do |user, options|
          AccountEntity.user_type_id user
        end 
        expose :avatar_thumb_url do |user, options|
          AccountEntity.avatar_thumb_url user.avatar
        end
      end

    end
  end
end