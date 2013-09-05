module Auth
  module RqrcodeToken
    extend ActiveSupport::Concern

    included do
      before_create :generate_rqrcode_token!, prepend: true
    end

    # Generate a token by looping and ensuring does not already exist.
    def generate_rqrcode_token
      loop do
        token = Devise.friendly_token
        break detail.rqrcode_token = token unless detail.class.where(rqrcode_token: token).any?
      end
    end

    def generate_rqrcode_token!
      generate_rqrcode_token && detail.save(validate: false)
    end

    def ensure_rqrcode_token!
      generate_rqrcode_token! unless detail.rqrcode_token
    end

  end
end