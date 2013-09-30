class Provider < Account
  include Accounts::RqrcodeTokenable
  set_detail_class Accounts::ProviderDetail

  validates_presence_of :type

end
