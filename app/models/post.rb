class Post < ActiveRecord::Base
  include Share::Userable
  include Share::Commentable

  belongs_to :club
  
  extend Share::ImageAttachments
  define_image_method

  attr_accessible :content, :image
  attr_accessible :user

  validates_presence_of :user, :content

  before_save do
    self.club = user.club
  end

  scope :with_friends, ->(user) { with_user(user.friend_ids - user.post_blacklist_ids) }
  scope :top, -> { order('comments_count DESC') }

  def self.view id
    post = find(id)
    post.increment!(:view_count)
    post
  end

  def serializable_hash(options={})
    options = { 
      only: [:id, :content, :view_count, :comments_count, :created_at],
      images: [:image],
      include: [:user],
    }.update(options)
    super(options)
  end

end
