module Accounts::Publicable
  extend  ActiveSupport::Concern

  included do
    include Accounts::Acceptable
    include Accounts::Rankable

    include Share::Displayable

    scope :followed_counted, -> {
      select("#{table_name}.*, count(friend.id) AS followed_count").
      joins('LEFT OUTER JOIN friend ON friend.friend_id = accounts.id').
      group('accounts.id')
    }

    scope :followed, -> { followed_counted.order("followed_count DESC") }

    scope :ordered, -> { displayed.followed.positioned }
  end

  # statistic
  def inverse_friends_count
    inverse_friends.count
  end

  def expire_at
    accepted_at + 1.year if accepted?
  end

  def adverts_balance
    inverse_friends_count * 3
  end

  def commission
    0
  end

  def income
    0
  end

  module ClassMethods

  end
end
