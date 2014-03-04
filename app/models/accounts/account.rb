class Accounts::Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
    :validatable, :confirmable#, :lockable#, :trackable

  include Accounts::TokenAuthenticatable

  # For details
  include Share::Detailable

  # For friendships
  include Accounts::Friendshipable

  # For avatar
  extend Share::ImageAttachments
  define_avatar_method

  validates_presence_of :username, :type
  validates_uniqueness_of :username
  validates_length_of :username, :within => 2..20, :allow_blank => true

  include Share::Queryable
  define_queryable_column :username, :mobile

  include Share::Areable
  enumerate :brand, with: Category::Brand
  enumerate :sex, with: %w(男 女)

  def user_type
    @user_type ||= if new_record?
      :guest
    elsif not type
      :account
    else
      type.demodulize.underscore.to_sym
    end
  end

  def admin?; false; end

  def public?; false; end

  def user?; false; end

  def human_user_type
    {
      guest: '访客',
      admin: '管理员',
      user: '车主',
      dealer: '服务商',
      provider: '媒体',
      distributor: '经销商',
      agent: '代理商',
    }[user_type]
  end

  def user_type_id
    {
      guest: 1,
      admin: 2,
      user: 3,
      dealer: 4,
      provider: 5,
      distributor: 6,
      agent: 7,
    }[user_type]
  end

  def avatar_thumb_url
    "#{AbsoluteUrlPrefix}#{avatar.url(:thumb, timestamp: false)}" if avatar.present?
  end

  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :username, :mobile, :description, :user_type
      json.image! self, :avatar
    end
  end

  def to_with_token_builder
    json = to_base_builder
    json.extract! self, :authentication_token
    json
  end

  def to_detail_builder
    json = to_base_builder
    json.detail detail.to_base_builder
    json
  end

  def to_openfire_user_info_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :mobile, :user_type_id
      json.token authentication_token
    end
  end

  def to_openfire_user_detail_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :username, :mobile, :user_type_id, :avatar_thumb_url
      json.sex_id(sex_id||0)
    end
  end

  def self.group_by_area_and_type
    hash = all.group_by(&:area_id)
    hash.update hash do |key, value|
      value.group_by(&:user_type)
    end
  end

end
