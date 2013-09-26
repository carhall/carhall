class Activity < ActiveRecord::Base
  include Share::Servicable

  extend Share::ImageAttachments
  define_image_method

  include Share::Areable
  include Share::Localizable
  
  attr_accessible :title, :expire_at, :description, :image

  validates_presence_of :title, :expire_at

  include Share::Expiredable

  def serializable_hash(options={})
    options = { 
      only: [:title, :expire_at, :description],
      images: [:image],
      include: [:dealer],
    }.update(options)
    super(options)
  end
  
  def detail_hash
    serializable_hash(include: {dealer: {include: :detail}})
  end
end
