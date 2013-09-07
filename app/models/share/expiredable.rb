module Share
  module Expiredable 
    extend ActiveSupport::Concern

    included do
      extend Share::ParseTime
      define_parse_time_method :expire_at

      scope :expired, -> { where("expire_at < ?", Time.now) }
      scope :in_progress, -> { where("expire_at > ?", Time.now) }
    end

  end
end