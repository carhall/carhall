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

  module ClassMethods

  end
end
