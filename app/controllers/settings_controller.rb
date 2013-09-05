class SettingsController < ApplicationController
  ensure_base_user_type :provider, :dealer

  def show
    render @user_type, layout: @user_type.to_s
  end

  def rqrcode
    respond_to do |format|
      format.svg  { render qrcode: @user.detail.rqrcode_token, level: :l, unit: 10 }
      format.png  { render qrcode: @user.detail.rqrcode_token }
      format.gif  { render qrcode: @user.detail.rqrcode_token }
      format.jpeg { render qrcode: @user.detail.rqrcode_token }
    end
  end
end
