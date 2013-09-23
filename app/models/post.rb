class Post < ActiveRecord::Base
  include Share::Userable
  
  belongs_to :club
  has_many :comments
  
  extend Share::ImageAttachments
  define_image_method

  attr_accessible :content, :image
  attr_accessible :user

  validates_presence_of :user
  validates_presence_of :content

  before_create do
    self.club = user.club
  end

  def self.with_friends user
    with_user(user.friend_ids - user.post_blacklist_ids)
  end

  def self.top
    unscoped.order('comments_count DESC, id DESC')
  end

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
