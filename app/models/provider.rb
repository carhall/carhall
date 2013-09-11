class Provider < Account
  include Share::RqrcodeToken

  set_detail_class Accounts::ProviderDetail

end
