class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
    :validatable, :confirmable#, :lockable#, :trackable

  include Accounts::Acceptable
  include Accounts::TokenAuthenticatable

  # For details
  include Share::Detailable

  # For friendships
  include Accounts::Friendshipable

  # For avatar
  extend Share::ImageAttachments
  define_avatar_method

  validates_presence_of :username, :type
  validates_length_of :username, :within => 2..20, :allow_blank => true

  def accepted
    accepted?
  end

  def user_type
    return :guest if new_record?
    return :account unless type
    type.underscore.to_sym
  end

  acts_as_api

  api_accessible :base do |t|
    t.only :id, :username, :mobile, :description
    t.methods :user_type, :accepted
    t.images :avatar
  end 

  api_accessible :with_token, extend: :base do |t|
    t.only :authentication_token
  end 

  api_accessible :detail, extend: :base do |t|
    t.add :detail, template: :base
  end

  # Fake detail
  attr_accessor :detail
  def detail
    @detail ||= account.build_detail rescue OpenStruct.new
  end
  def detail_attributes= hash=nil
  end
end
