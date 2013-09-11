class Provider < User
  include Share::RqrcodeToken

  set_detail_class Accounts::ProviderDetail

  validates_presence_of :user_type_id

end
