class Api::AdvertsController < Api::ApplicationController
  skip_before_filter :authenticate_account_from_token!
  set_resource_class Business::Advert
  # before_filter :set_current_user
  before_filter :set_filter

  def set_filter
    filter_parent :advert_type
  end

end
