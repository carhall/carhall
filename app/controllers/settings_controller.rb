class SettingsController < ApplicationController
  prepend_before_filter :ensure_user_type
  before_filter :set_dealer, only: [:finance, :template]

  def show
  end

  def finance
  end

  def template
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
