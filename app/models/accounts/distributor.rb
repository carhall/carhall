class Accounts::Distributor < Accounts::Account
  include Accounts::Publicable
  include Accounts::RqrcodeTokenable

  include Share::Localizable

  set_detail_class Accounts::DistributorDetail

  before_save do
    detail.main_area = province if detail
  end

end
