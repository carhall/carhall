class ApplicationController < ActionController::Base
  protect_from_forgery

  include FilterHelper
  before_filter :set_user_type

end
