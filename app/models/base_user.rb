require_relative 'auth/confirmable'
require_relative 'auth/validatable'

class BaseUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :validatable#, :confirmable
         #:trackable

  # For details
  include Share::Detailable
  alias_method :user_type, :detail_type_sym
  attr_accessor :user_type_id

  # For friendships
  include Share::Friendshipable

  # For avatar
  extend Share::ImageFile
  define_image_methods :avatar

  # For posts
  has_many :posts, foreign_key: :user_id

  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :remember_me
  attr_accessible :username, :mobile, :description, :avatar
  attr_accessible :detail, :user_type_id

  def serializable_hash(options={})
    options = { 
      only: [:id, :username, :mobile, :destription],
      methods: [:avatar_thumb_url, :avatar_url, :user_type],
      # include: [:detail],
    }.update(options)
    super(options)
  end

  def detail_hash
    serializable_hash(include: [:detail])
  end

end


