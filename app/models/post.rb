class Post < ActiveRecord::Base
  include Share::Userable
  include Share::Commentable

  belongs_to :club
  
  has_attached_file :image, styles: { medium: "300x200>", thumb: "60x60>" }

  attr_accessible :content, :image
  attr_accessible :user

  before_save do
    raise CanCan::AccessDenied unless user.user_type == :user
    self.club = user.club
  end

  scope :with_friends, ->(user) { with_user(user.friend_ids - user.blacklist_ids) }
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
