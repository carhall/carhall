class Activity < ActiveRecord::Base
  belongs_to :dealer

  extend Share::ImageAttachments
  define_image_method

  attr_accessible :title, :expire_at, :description, :image

  validates_presence_of :title, :expire_at

  def expire_at_before_type_cast
    expire_at.strftime("%Y-%m-%d %H:%M") if expire_at
  end

  include Share::Expiredable

  def serializable_hash(options={})
    options = { 
      only: [:title, :expire_at, :description],
      images: [:image],
      include: [:dealer],
    }.update(options)
    super(options)
  end
  
end
