class Provider < BaseUser
  include Auth::RqrcodeToken

  set_detail_class Auth::ProviderInfo

end
