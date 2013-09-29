class Activity < ActiveRecord::Base
  include Share::Servicable

  extend Share::ImageAttachments
  define_image_method

  include Share::Areable
  include Share::Localizable
  
  attr_accessible :title, :expire_at, :description, :image

  validates_presence_of :title, :expire_at

  include Share::Expiredable

  acts_as_api

  api_accessible :base do |t|
    t.only :id, :title, :expire_at, :description
    t.images :image
    t.add :dealer, template: :base
  end 

  def detail_hash
    serializable_hash(include: {dealer: {include: :detail}})
  end
end
