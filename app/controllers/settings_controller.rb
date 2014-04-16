class SettingsController < ApplicationController
  authorize_resource class: false
  before_filter :set_dealer, only: [:finance, :template, :weixin]
  before_filter :set_provider, only: [:template]
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

  def weixin
    @user.ensure_weixin_token!
    step = params[:step] || "step1"
    render "settings/weixin/#{step}"
  end
end
