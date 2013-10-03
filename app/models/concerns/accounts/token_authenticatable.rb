module Accounts::TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    # You likely have this before callback set up for the token.
    before_save :ensure_authentication_token
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def ensure_authentication_token!
    ensure_authentication_token && save(validate: false)
  end
 
  def reset_authentication_token
    self.authentication_token = generate_authentication_token
  end
 
  def reset_authentication_token!
    reset_authentication_token && save(validate: false)
  end
  
  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless self.class.where("authentication_token" => token).exists?
    end
  end
end
