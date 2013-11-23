class Business::Advert < ActiveRecord::Base
  enumerate :advert_type, with: %w(客户端首页 客户端锦囊 客户端在下 公众平台广告模板 公众平台在线教程)
  # enumerate :area, with: Category::Area::Main
  enumerate :brand, with: Category::Brand
  include Share::Areable
 
  has_attached_file :image, styles: { medium: "480x220>", thumb: "60x60#" }

  validates_presence_of :image, :advert_type_id

  def image_url
    "#{AbsoluteUrlPrefix}#{image.url(:medium)}"
  end

  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :image_url
    end
  end

  scope :client, -> { where(advert_type_id: [1, 2, 3]) }
  scope :ad_template, -> { where(advert_type_id: 4) }
  scope :tutorial, -> { where(advert_type_id: 5) }
end