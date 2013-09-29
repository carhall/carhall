class Activity < ActiveRecord::Base
  include Share::Servicable

  extend Share::ImageAttachments
  define_image_method

  enumerate :area, with: Share::Area
  include Share::Localizable
  
  attr_accessible :title, :expire_at, :description, :image

  validates_presence_of :title, :expire_at

  include Share::Expiredable

  api_accessible :base do |t|
    t.only :id, :title, :expire_at, :description
    t.images :image
    t.add :dealer, template: :base
  end 

  api_accessible :detail, extend: :base do |t|
    t.add :dealer, template: :detail
  end 

end
