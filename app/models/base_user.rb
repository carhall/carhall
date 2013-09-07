require_relative 'auth/authenticatable'
require_relative 'auth/acceptable'
require_relative 'auth/confirmable'
require_relative 'auth/validatable'
require_relative 'auth/lockable'

class BaseUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :validatable, :confirmable#, :lockable#, :trackable

  include Auth::Acceptable

  # For details
  include Share::Detailable
  alias_method :user_type, :detail_type_sym
  attr_accessor :user_type_id

  # For friendships
  include Share::Friendshipable

  # For avatar
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "60x60>" },
    path: ':rails_root/public/system/base_users/:attachment/:id_partition/:style/:filename'

  # For posts
  has_many :posts, foreign_key: :user_id

  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :remember_me
  attr_accessible :username, :mobile, :description, :avatar
  attr_accessible :detail, :user_type_id

  def serializable_hash(options={})
    options = {
      only: [:id, :username, :mobile, :destription],
      methods: [:user_type],
      images: [:avatar]
      # include: [:detail],
    }.update(options)
    super(options)
  end

  def detail_hash
    serializable_hash(include: [:detail])
  end

end


