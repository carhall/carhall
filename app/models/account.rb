require_relative 'accounts/share/authenticatable'
require_relative 'accounts/share/confirmable'
require_relative 'accounts/share/validatable'
require_relative 'accounts/share/lockable'

class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :validatable#, :confirmable#, :lockable#, :trackable

  include Share::Acceptable

  # For details
  include Share::Detailable
  alias_method :user_type, :type_sym

  # For friendships
  include Share::Friendshipable

  # For avatar
  extend Share::ImageAttachments
  define_avatar_method path: ':rails_root/public/system/users/:attachment/:id_partition/:style/:filename'

  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :remember_me
  attr_accessible :username, :mobile, :description, :avatar, :type
  attr_accessible :detail
  attr_accessible :detail_attributes

  validates_presence_of :username
  validates_length_of :username, :within => 2..20, :allow_blank => true

  def serializable_hash(options={})
    options = {
      only: [:id, :username, :mobile, :description],
      methods: [:user_type],
      images: [:avatar]
    }.update(options)
    super(options)
  end

  def detail_hash(options={})
    serializable_hash options.merge(include: :detail)
  end
end
