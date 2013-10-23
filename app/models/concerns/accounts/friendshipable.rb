module Accounts::Friendshipable
  extend ActiveSupport::Concern
    
  included do
    # For friendship, friends and inverse_friends
    has_many :friendships, class_name: 'Accounts::Friendship', foreign_key: :user_id
    has_many :friends, through: :friendships
    has_many :inverse_friendships, class_name: 'Accounts::Friendship', foreign_key: :friend_id
    has_many :inverse_friends, through: :inverse_friendships, source: :user

    has_many :user_friends, through: :friendships, source: :friend, class_name: 'Accounts::User'
    has_many :dealer_friends, through: :friendships, source: :friend, class_name: 'Accounts::Dealer'
    has_many :provider_friends, through: :friendships, source: :friend, class_name: 'Accounts::Provider'

    # For blocks, blacklists and inverse_blacklists
    has_many :blocks, class_name: 'Accounts::Block', foreign_key: :user_id
    has_many :blacklists, through: :blocks
    # has_many :inverse_blocks, class_name: 'Accounts::Block', foreign_key: :blacklist_id
    # has_many :inverse_blacklists, through: :inverse_blocks, source: :user

    # For blocks, blacklists and inverse_blacklists
    has_many :post_blocks, class_name: 'Posts::Block', foreign_key: :user_id
    has_many :post_blacklists, through: :post_blocks, source: :blacklist
    # has_many :inverse_post_blocks, class_name: 'Posts::Block', foreign_key: :blacklist_id
    # has_many :inverse_post_blacklists, through: :inverse_post_blocks, source: :user

  end

  def make_friend_with! friend
    friend_id = Share::Userable.get_id friend
    inverse_friendships.where(user_id: friend_id).first_or_create if user_type != :user
    friendships.where(friend_id: friend_id).first_or_create
  end

  def break_with! friend
    friend_id = Share::Userable.get_id friend
    friendships.where(friend_id: friend_id).delete_all
  end

  def add_to_blacklist! blacklist
    blacklist_id = Share::Userable.get_id blacklist
    blocks.where(blacklist_id: blacklist_id).first_or_create
  end
  
  def add_to_post_blacklist! blacklist
    blacklist_id = Share::Userable.get_id blacklist
    post_blocks.where(blacklist_id: blacklist_id).first_or_create
  end

  def remove_from_blacklist! blacklist
    blacklist_id = Share::Userable.get_id blacklist
    blocks.where(blacklist_id: blacklist_id).delete_all
  end

  def remove_from_post_blacklist! blacklist
    blacklist_id = Share::Userable.get_id blacklist
    post_blocks.where(blacklist_id: blacklist_id).delete_all
  end

end
