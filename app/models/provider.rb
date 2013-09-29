class Provider < Account
  include Accounts::RqrcodeToken
  set_detail_class Accounts::ProviderDetail

  validates_presence_of :type

end
