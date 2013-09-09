class Activity < ActiveRecord::Base
  belongs_to :dealer

  has_attached_file :image, styles: { medium: "300x200#", thumb: "60x60#" }

  attr_accessible :title, :expire_at, :description, :image

  validates_presence_of :title, :expire_at

  def expire_at_before_type_cast
    expire_at.strftime("%Y-%m-%d %H:%M")
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