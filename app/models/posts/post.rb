class Posts::Post < ActiveRecord::Base
  include Share::Userable
  belongs_to :user, counter_cache: true, class_name: 'Accounts::User'
  
  belongs_to :club
  has_many :comments, as: :source, class_name: 'Posts::Comment'
  
  extend Share::ImageAttachments
  define_image_method

  validates_presence_of :user
  validates_presence_of :content

  before_create do
    self.club = user.club
  end

  default_scope { order('id DESC') }

  scope :top, -> { reorder('comments_count DESC, id DESC') }

  def self.with_friends user
    with_user(user.friend_ids - user.post_blacklist_ids)
  end

  acts_as_api

  api_accessible :base, includes: [:user, comments: [:user, :at_user]] do |t|
    t.only :id, :content, :view_count, :comments_count, :created_at
    t.images :image
    t.add :user, template: :base
    t.add :comments, template: :base
  end

end
