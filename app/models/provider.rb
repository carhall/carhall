class Provider < BaseUser
  include Auth::RqrcodeToken

  set_detail_class Auth::ProviderDetail

  validates_presence_of :user_type_id

end
