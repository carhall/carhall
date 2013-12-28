class DashboardsController < ApplicationController
  skip_before_filter :authenticate_account!

  def show
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
