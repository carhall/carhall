class Posts::Post < ActiveRecord::Base
  include Share::Userable
  belongs_to :user, counter_cache: true
  
  belongs_to :club
  has_many :comments, as: :source, class_name: 'Posts::Comment'
  
  extend Share::ImageAttachments
  define_image_method

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

  acts_as_api

  api_accessible :base do |t|
    t.only :id, :content, :view_count, :comments_count, :created_at
    t.images :image
    t.add :user, template: :base
  end

end
