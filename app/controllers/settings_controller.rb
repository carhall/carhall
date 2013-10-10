class SettingsController < ApplicationController
  authorize_resource class: false
  before_filter :set_dealer, only: [:finance, :template]
  before_filter :ensure_rqrcode_image

  def ensure_rqrcode_image
    @user.ensure_rqrcode_image!
  end

  def show
  end

  def finance
  end

  def template
  end
end
