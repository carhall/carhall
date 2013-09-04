class SettingsController < ApplicationController
  ensure_base_user_type :provider, :dealer

  def show
    render current_base_user_type, layout: current_base_user_type.to_s
  end
end
