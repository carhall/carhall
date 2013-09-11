class Provider < Account
  include Share::RqrcodeToken
  set_detail_class Accounts::ProviderDetail

  validates_presence_of :type

end
