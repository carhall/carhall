module Share
  module Expiredable 
    extend ActiveSupport::Concern

    included do
      extend Share::ParseTime
      define_parse_time_method :expire_at

      scope :expired, -> { where("expire_at < ?", Time.now) }
      scope :in_progress, -> { where("expire_at > ?", Time.now) }
    end

    def expire_at_before_type_cast
      expire_at.strftime("%Y-%m-%d %H:%M") if expire_at
    end

  end
end