module Share
  module Friendshipable
    extend ActiveSupport::Concern
      
    included do
      # For friendship, friends and inverse_friends
      has_many :friendships, class_name: "Auth::Friendship", foreign_key: "user_id"
      has_many :friends, through: :friendships
      has_many :inverse_friendships, class_name: "Auth::Friendship", foreign_key: "friend_id"
      has_many :inverse_friends, through: :inverse_friendships, source: :user
    end
    
    def make_friend_with friend_id
      friendships.where(friend_id: friend_id).first_or_initialize
    end

    def break_with friend_id
      friendship = friendships.where(friend_id: friend_id).first
      friendship.destroy if friendship
    end

  end
end