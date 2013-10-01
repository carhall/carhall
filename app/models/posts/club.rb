class Posts::Club < ActiveRecord::Base
  enumerate :area, with: Share::Area
  enumerate :brand, with: Share::Brand

  belongs_to :president, class_name: 'Accounts::User'
  has_many :posts

  has_many :mechanic_candidates, class_name: 'Posts::MechanicCandidate', as: :source
  has_many :president_candidates, class_name: 'Posts::PresidentCandidate', as: :source
  
  extend Share::ImageAttachments
  define_avatar_method

  extend Share::Ids2Users
  define_ids2users_methods :mechanics
  
  # attr_accessible :area_id, :brand_id, :announcement, :avatar

  def self.with_club area_id, brand_id
    where(area_id: area_id, brand_id: brand_id).first_or_create
  end

  def self.with_user user
    detail = user.detail
    with_club detail.area_id, detail.brand_id
  end

  def apply_president user, description
    user_id = Share::Userable.get_id user
    president_candidates.new(user_id: user_id, description: description)
  end

  def apply_mechanic user, description
    user_id = Share::Userable.get_id user
    mechanic_candidates.new(user_id: user_id, description: description)
  end

  def appoint_president user
    user_id = Share::Userable.get_id user
    self.president_id = user_id
  end

  def appoint_mechanic user
    user_id = Share::Userable.get_id user
    mechanic_ids << user_id
    mechanic_ids.uniq!
  end

  extend Share::Exclamation
  define_exclamation_dot_method :apply_president
  define_exclamation_dot_method :apply_mechanic
  define_exclamation_and_method :appoint_president
  define_exclamation_and_method :appoint_mechanic

  acts_as_api

  api_accessible :base do |t|
    t.only :id, :announcement
    t.methods :president, :mechanics
    t.images :avatar
  end
  
end