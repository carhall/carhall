class Accounts::Distributor < Accounts::Account
  include Accounts::Publicable
  include Accounts::RqrcodeTokenable

  include Share::Localizable

  include Accounts::Weixinable

  before_save do
    if detail.weixin_app_id_changed? or detail.weixin_app_secret_changed?
      update_weixin
    end
  end
  
  set_detail_class Accounts::DistributorDetail

  has_many :bulk_purchasing2s, class_name: 'Tips::BulkPurchasing2'
  has_many :bulk_purchasing2_orders, class_name: 'Tips::BulkPurchasing2Order'

  has_many :manual_images, class_name: 'Tips::ManualImage'
  has_many :construction_cases, class_name: 'Tips::ConstructionCase'

  has_and_belongs_to_many :ad_templates, class_name: 'Business::AdTemplate'

  scope :with_business_scope, -> (business_scope) {
    detail_ids = Accounts::DistributorDetail.with_business_scope(business_scope).pluck(:id)
    where(detail_id: detail_ids)
  }

  scope :with_product, -> (product) {
    detail_ids = Accounts::DistributorDetail.with_product(product).pluck(:id)
    where(detail_id: detail_ids)
  }

  has_attached_file :avatar, styles: { medium: "300x200#", thumb: "60x60#" },
    path: ":rails_root/public/system/accounts/distributors/:attachment/:id_partition/:style/:filename",
    url: "/system/accounts/distributors/:attachment/:id_partition/:style/:filename"

  def has_template? template; true; end

  def can_use_template? template; true; end
  
  def agent?; false; end

  def rank_up
    self.type = 'Accounts::Agent'
  end

  def rank_down
    self.type = 'Accounts::Distributor'
  end

  extend Share::Exclamation
  define_exclamation_and_method :rank_up
  define_exclamation_and_method :rank_down
  
  
end