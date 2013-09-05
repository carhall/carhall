class ApplicationController < ActionController::Base
  protect_from_forgery

  include Api::FilterHelper
  before_filter :set_user_type

  def current_ability
    @current_ability ||= Ability.new(@user)
  end

  def self.ensure_base_user_type *user_types
    prepend_before_filter do
      set_user_type
      raise_base_user_access_denied *user_types
    end
  end

  def ensure_base_user_type *user_types
    raise_base_user_access_denied *user_types
  end

  def raise_base_user_access_denied *user_types
    raise CanCan::AccessDenied unless user_types.include? @user_type
  end
end
