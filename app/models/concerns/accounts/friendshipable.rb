module Accounts::Friendshipable
  extend ActiveSupport::Concern
    
  included do
    # For friendship, friends and inverse_friends
    has_many :friendships, class_name: 'Accounts::Friendship', foreign_key: :user_id
    has_many :friends, through: :friendships
    has_many :inverse_friendships, class_name: 'Accounts::Friendship', foreign_key: :friend_id
    has_many :inverse_friends, through: :inverse_friendships, source: :user

    # For blocks, blacklists and inverse_blacklists
    has_many :blocks, class_name: 'Accounts::Block', foreign_key: :user_id
    has_many :blacklists, through: :blocks
    # has_many :inverse_blocks, class_name: 'Accounts::Block', foreign_key: :blacklist_id
    # has_many :inverse_blacklists, through: :inverse_blocks, source: :user

    # For blocks, blacklists and inverse_blacklists
    has_many :post_blocks, class_name: 'Accounts::PostBlock', foreign_key: :user_id
    has_many :post_blacklists, through: :post_blocks, source: :blacklist
    # has_many :inverse_post_blocks, class_name: 'Accounts::PostBlock', foreign_key: :blacklist_id
    # has_many :inverse_post_blacklists, through: :inverse_post_blocks, source: :user

  end

  def make_friend_with friend
    friend_id = Share::Userable.get_id friend
    friendships.where(friend_id: friend_id).first_or_initialize
  end

  def break_with friend
    friend_id = Share::Userable.get_id friend
    friendship = friendships.where(friend_id: friend_id).first
    friendship.destroy if friendship
  end

  def add_to_blacklist blacklist
    blacklist_id = Share::Userable.get_id blacklist
    break_with blacklist_id
    blocks.where(blacklist_id: blacklist_id).first_or_initialize
  end
  
  def add_to_post_blacklist blacklist
    blacklist_id = Share::Userable.get_id blacklist
    post_blocks.where(blacklist_id: blacklist_id).first_or_initialize
  end

  def remove_from_blacklist blacklist
    blacklist_id = Share::Userable.get_id blacklist
    block = blocks.where(blacklist_id: blacklist_id).first
    block.destroy if block
  end

  def remove_from_post_blacklist blacklist
    blacklist_id = Share::Userable.get_id blacklist
    block = post_blocks.where(blacklist_id: blacklist_id).first
    block.destroy if block
  end

  extend Share::Exclamation
  define_exclamation_dot_method :make_friend_with
  define_exclamation_dot_method :add_to_blacklist
  define_exclamation_dot_method :add_to_post_blacklist
  
end
