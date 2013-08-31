class Activity < ActiveRecord::Base
  belongs_to :dealer

  extend Share::ImageFile
  define_image_methods :image

  def serializable_hash(options={})
    options = { 
      only: [:title, :expire_at, :description],
      methods: [:image_thumb_url, :image_url],
      include: [:dealer],
    }.update(options)
    super(options)
  end

end