class Accounts::Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
    :validatable#, :confirmable#, :lockable#, :trackable

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

  acts_as_indexed :fields => [:username]

  enumerate :area, with: Share::Area
  enumerate :brand, with: Share::Brand
  enumerate :sex, with: %w(男 女)

  def accepted
    accepted?
  end

  def user_type
    return :guest if new_record?
    return :account unless type
    return :superadmin if id == 1
    type.demodulize.underscore.to_sym
  end

  def human_user_type
    {
      guest: '访客',
      superadmin: '超级管理员',
      admin: '管理员',
      user: '车主',
      dealer: '服务商',
      provider: '媒体',
    }[user_type]
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
