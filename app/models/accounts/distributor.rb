class Accounts::Distributor < Accounts::Account
  include Accounts::Publicable
  include Accounts::RqrcodeTokenable

  include Share::Localizable

  set_detail_class Accounts::DistributorDetail

  has_many :bulk_purchasing2s, class_name: 'Tips::BulkPurchasing2'
  has_many :bulk_purchasing2_orders, class_name: 'Tips::BulkPurchasing2Order'

  scope :with_business_scope, -> (business_scope) {
    detail_ids = Accounts::DistributorDetail.with_business_scope(business_scope).pluck(:id)
    where(detail_id: detail_ids)
  }

  scope :with_product, -> (product) {
    detail_ids = Accounts::DistributorDetail.with_product(product).pluck(:id)
    where(detail_id: detail_ids)
  }

end
