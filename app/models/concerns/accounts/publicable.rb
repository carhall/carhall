module Accounts::Publicable
  extend  ActiveSupport::Concern

  included do
    include Accounts::Acceptable
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
