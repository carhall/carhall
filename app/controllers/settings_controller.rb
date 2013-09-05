class SettingsController < ApplicationController
  ensure_base_user_type :provider, :dealer

  def show
  end

  def finance
    ensure_base_user_type :dealer
  end

  def template
    ensure_base_user_type :dealer
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
