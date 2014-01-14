class DashboardsController < ApplicationController
  skip_before_filter :authenticate_account!, except: :send_invitation

  def show
  end
  
  def send_invitation
    @current_user.send_invitation_instructions params[:invite_mobile]
    redirect_to dashboard_path
  end

  def download_apk
    apk_latest = ::Business::ClientVersion.apk_latest
    if apk_latest
      redirect_to apk_latest.download_url
    else
      render nothing: true, status: :no_content
    end
  end

end
