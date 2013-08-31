class Post < ActiveRecord::Base
  include Share::Userable
  include Share::Commentable
  include Share::Areable
  include Share::Brandable

  extend Share::ImageFile
  define_image_methods :image

  attr_accessible :content, :image

  before_save do
    if user.user_type == :user
      user_detail = user.detail
      self.area_id = user_detail.area_id
      self.brand_id = user.detail.brand_id
    end
  end

  def self.view id
    post = find(id)
    post.increment!(:view_count)
    post
  end

  def serializable_hash(options={})
    options = { 
      only: [:id, :content, :view_count, :comments_count, :created_at],
      methods: [:image_thumb_url, :image_url, :area, :brand],
      include: [:user]
    }.update(options)
    super(options)
  end

end
