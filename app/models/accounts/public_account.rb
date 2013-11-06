class Accounts::PublicAccount < Accounts::Account
  include Accounts::Publicable
  include Accounts::RqrcodeTokenable


end
