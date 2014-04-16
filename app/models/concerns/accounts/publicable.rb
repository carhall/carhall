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
    validates_presence_of :area_id, :type

    scope :followed, -> { order("friends_count DESC") }
    scope :ordered, -> { displayed.followed.positioned }

  end

  def phone
    detail.phone || mobile rescue mobile
  end

  def public?
    true
  end

  def expire_at
    accepted_at + 1.year if accepted?
  end

  def adverts_balance
    (friends_count||0) * 3
  end

  def commission
    0
  end

  def income
    0
  end

  def ensure_weixin_token
    generate_weixin_token unless weixin_token
  end

  def generate_weixin_token
    raw, enc = Devise.token_generator.generate_number(self.class, :weixin_token)
    self.weixin_token = raw
  end

  extend Share::Exclamation
  define_exclamation_and_method :ensure_weixin_token
  define_exclamation_and_method :generate_weixin_token
  
end
