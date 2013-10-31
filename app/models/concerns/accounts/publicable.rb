module Accounts::Publicable
  extend  ActiveSupport::Concern

  included do
    include Accounts::Acceptable
    include Accounts::Rankable

    include Share::Displayable

    def accept
      super
      expose
    end

    def reject
      super
      hide
    end

    validates_presence_of :detail

    scope :followed, -> { order("friends_count DESC") }
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

end
