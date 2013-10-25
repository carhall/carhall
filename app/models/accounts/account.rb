class Accounts::Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
    :validatable#, :confirmable#, :lockable#, :trackable

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

  include Share::Queryable
  define_queryable_column :username, :mobile

  acts_as_api

  enumerate :area, with: Category::Area
  alias_method :city, :area
  def province
    area(:province)
  end

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

  def admin?
    false
  end

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

  acts_as_api

  api_accessible :base do |t|
    t.only :id, :username, :mobile, :description
    t.methods :user_type
    t.images :avatar
  end 

  api_accessible :with_token, extend: :base do |t|
    t.only :authentication_token
  end 

  api_accessible :detail, extend: :base, includes: [:detail] do |t|
    t.add :detail, template: :base
  end

  # Fake detail
  attr_accessor :detail
  def detail
    @detail ||= account.build_detail rescue OpenStruct.new
  end
  def detail_attributes= hash=nil
  end

  def self.init_grouped_array_by_area_and_type
    areas_count = Category::Area.all.count
    Array.new(areas_count+1) { { 
      guest: [],
      admin: [],
      user: [],
      dealer: [],
      provider: [],
      distributor: [],
    } }
  end

  def self.group_by_area_and_type
    accounts = all
    grouped_accounts = init_grouped_array_by_area_and_type
    accounts.each do |account|
      grouped_accounts[account.area_id||0][account.user_type] << account
    end
    grouped_accounts
  end

end
