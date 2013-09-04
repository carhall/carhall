class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_ability
    @current_ability ||= Ability.new(current_base_user)
  end

  def self.ensure_base_user_type *user_types
    prepend_before_filter do
      raise_base_user_access_denied *user_types
    end
  end

  def ensure_base_user_type *user_types
    raise_base_user_access_denied *user_types
  end

  def raise_base_user_access_denied *user_types
    raise CanCan::AccessDenied unless user_types.include? current_base_user_type
  end

  def current_base_user_type
    @user_type ||= (current_base_user || BaseUser.new).user_type
  end
end
