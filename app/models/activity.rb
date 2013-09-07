class Activity < ActiveRecord::Base
  belongs_to :dealer

  has_attached_file :image, styles: { medium: "300x200>", thumb: "60x60>" }

  def serializable_hash(options={})
    options = { 
      only: [:title, :expire_at, :description],
      images: [:image],
      include: [:dealer],
    }.update(options)
    super(options)
  end

end