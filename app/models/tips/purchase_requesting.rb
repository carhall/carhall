class Tips::PurchaseRequesting < ActiveRecord::Base
  include Share::Dealerable

  default_scope { order('id DESC') }
  
  before_save do
    self.main_area = dealer.province
  end

  extend Share::ImageAttachments
  define_image_method

  enumerate :area, with: Category::Area

  validates_presence_of :dealer  
  validates_presence_of :title, :purchase_requesting_type_id, :expire_at, :price_range

  enumerate :purchase_requesting_type, with: %w(美容 用品 配件 工具 其它)

  include Tips::Expiredable

end