class Posts::Club < ActiveRecord::Base
  enumerate :area, with: Category::Area
  enumerate :brand, with: Category::Brand

  belongs_to :president, class_name: 'Accounts::User'
  has_many :posts

  has_many :mechanic_candidates, class_name: 'Posts::MechanicCandidate', as: :source
  has_many :president_candidates, class_name: 'Posts::PresidentCandidate', as: :source
  has_and_belongs_to_many :mechanics, -> { uniq }, class_name: 'Accounts::User'
  
  extend Share::ImageAttachments
  define_avatar_method

  def self.with_club area_id, brand_id
    where(area_id: area_id, brand_id: brand_id).first_or_create
  end

  def self.with_user user
    with_club user.area_id, user.brand_id
  end

  def apply_president user, description
    president_candidate = president_candidates.where(user: user).first_or_initialize
    president_candidate.description = description
    president_candidate
  end

  def apply_mechanic user, description
    mechanic_candidate = mechanic_candidates.where(user: user).first_or_initialize
    mechanic_candidate.description = description
    mechanic_candidate
  end

  def appoint_president user
    self.president = user
  end

  def appoint_mechanic user
    self.mechanics << user
  end

  def relieve_president
    self.president = nil
  end

  def relieve_mechanic user
    self.mechanics.delete user
  end

  def title
    "#{area}#{brand}车友会"
  end

  extend Share::Exclamation
  define_exclamation_dot_method :apply_president
  define_exclamation_dot_method :apply_mechanic
  define_exclamation_and_method :appoint_president
  define_exclamation_and_method :appoint_mechanic
  define_exclamation_and_method :relieve_president
  define_exclamation_and_method :relieve_mechanic

  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :title, :announcement
      json.builder! self, :president, :base
      json.mechanics mechanics.map{|m|m.to_base_builder.attributes!}
      json.image! self, :avatar
    end
  end

end