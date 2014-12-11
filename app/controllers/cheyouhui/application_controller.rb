class Cheyouhui::ApplicationController < ApplicationController #ActionController::Base

  #protect_from_forgery
  #include FilterHelper
  #before_filter :authenticate_from_session
  #before_filter :set_current_user
  #before_filter :set_user_type

  def authenticate_from_session
  	#binding.pry
  end
end