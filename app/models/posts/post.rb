class Posts::Post < ActiveRecord::Base
  include Share::Userable
  belongs_to :user, counter_cache: true, class_name: 'Accounts::User'
  
  has_many :comments, as: :source, class_name: 'Posts::Comment'
  
  extend Share::ImageAttachments
  define_image_method

  validates_presence_of :user
  validates_presence_of :content

  before_create do
    self.area_id ||= user.area_id
    self.brand_id ||= user.brand_id
  end

  before_save do
    self.user_username ||= user.username
    self.user_description ||= user.description
    self.user_avatar_thumb_url ||= user.avatar.url(:thumb, timestamp: false) if user.avatar.present?
  end

  def user_avatar_thumb_url
    "#{AbsoluteUrlPrefix}#{super}" if super.present?
  end

  def user_avatar_medium_url
    user_avatar_thumb_url.gsub("thumb", "medium") if user_avatar_thumb_url.present?
  end

  default_scope { order('id DESC') }

  scope :top, -> { reorder('comments_count DESC, id DESC') }

  scope :with_friends, -> (user) {
    with_user(user.friend_ids - user.post_blacklist_ids)
  }

  scope :with_club, -> (user) {
    if user.admin?
      self
    elsif user.public?
      where(area_id: user.area_id)
    elsif user.user?
      where(area_id: user.area_id, brand_id: user.brand_id)
    end
  }

  def to_without_comment_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :content, :comments_count, :created_at
      json.image! self, :image
      json.user do |json|
        json.id self.user_id
        json.username self.user_username
        json.description self.user_description
        json.avatar_thumb_url self.user_avatar_thumb_url
        json.avatar_medium_url self.user_avatar_medium_url
      end
    end
  end
    
  def to_base_builder
    json = to_without_comment_builder
    json.comments comments.map { |c| c.to_base_builder.attributes! }
    json
  end

end
