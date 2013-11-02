class Business::Advert < ActiveRecord::Base
  enumerate :advert_type, with: %w(客户端首页 客户端锦囊)
  enumerate :area, with: Category::Area
  enumerate :brand, with: Category::Brand
 
  extend Share::ImageAttachments
  define_image_method

  validates_presence_of :image, :advert_type_id

  acts_as_api

  def image_url
    "#{AbsoluteUrlPrefix}#{image.url}"
  end

  api_accessible :base do |t|
    t.only :id
    t.methods :image_url
  end
end