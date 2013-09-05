module Auth
  module RqrcodeToken
    extend ActiveSupport::Concern

    included do
      before_create do
        generate_rqrcode_token
      end
    end

    # Generate a token by looping and ensuring does not already exist.
    def generate_rqrcode_token
      loop do
        token = Devise.friendly_token
        break detail.rqrcode_token = token unless detail.class.where(rqrcode_token: token).any?
      end
    end

  end
end