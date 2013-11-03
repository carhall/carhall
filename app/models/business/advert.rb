class Business::Advert < ActiveRecord::Base
  enumerate :advert_type, with: %w(客户端首页 客户端锦囊 客户端在下 公众平台广告模板 公众平台在线教程)
  enumerate :area, with: Category::Area
  enumerate :brand, with: Category::Brand
 
  has_attached_file :image, styles: { medium: "480x220>", thumb: "60x60#" }

  validates_presence_of :image, :advert_type_id

  acts_as_api

  def image_url
    "#{AbsoluteUrlPrefix}#{image.url(:medium)}"
  end

  api_accessible :base do |t|
    t.only :id
    t.methods :image_url
  end

  scope :client, -> { where(advert_type_id: [1, 2, 3]) }
  scope :ad_template, -> { where(advert_type_id: 4) }
  scope :tutorial, -> { where(advert_type_id: 5) }
end