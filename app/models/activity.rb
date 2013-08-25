class Activity < ActiveRecord::Base
  belongs_to :dealer

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }

  def serializable_hash(options={})
    options = { 
      only: [:title, :expire_at, :description],
      methods: [:image],
      include: [:dealer],
    }.update(options)
    super(options)
  end

end