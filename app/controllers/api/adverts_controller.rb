class Api::AdvertsController < Api::ApplicationController
  skip_before_filter :authenticate_account_from_token!
  set_resource_class Business::Advert
  # before_filter :set_current_user
  before_filter :hotfix_android
  before_filter :set_filter

  def set_filter
    filter_parent :advert_type
  end

  def hotfix_android
    params[:advert_type] = params[:brand]
    params[:advert_type_id] = params[:brand_id]
  end

end
