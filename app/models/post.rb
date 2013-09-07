class Post < ActiveRecord::Base
  include Share::Userable
  include Share::Commentable
  include Share::Areable
  include Share::Brandable

  has_attached_file :image, styles: { medium: "300x200>", thumb: "60x60>" }

  attr_accessible :content, :image
  attr_accessible :user

  before_save do
    if user.user_type == :user
      user_detail = user.detail
      self.area_id = user_detail.area_id
      self.brand_id = user.detail.brand_id
    end
  end

  scope :friends, ->(user) { with_user(user.friend_ids - user.blacklist_ids) }
  scope :top, -> { order('comments_count DESC') }
  scope :club, ->(area_id, brand_id) { where(area_id: area_id, brand_id: brand_id) }

  def self.view id
    post = find(id)
    post.increment!(:view_count)
    post
  end

  def serializable_hash(options={})
    options = { 
      only: [:id, :content, :view_count, :comments_count, :created_at],
      methods: [:area, :brand],
      images: [:image],
      include: [:user],
    }.update(options)
    super(options)
  end

end
