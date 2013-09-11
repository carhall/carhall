class Club < ActiveRecord::Base
  include Share::Areable
  include Share::Brandable

  belongs_to :president, class_name: "User"
  has_many :posts
  
  extend Share::ImageAttachments
  define_avatar_method

  extend Share::Ids2Users
  define_ids2users_methods :president_candidates
  define_ids2users_methods :mechanics
  define_ids2users_methods :mechanic_candidates
  
  attr_accessible :area_id, :brand_id, :announcement, :avatar

  def self.with_club area_id, brand_id
    where(area_id: area_id, brand_id: brand_id).first_or_create
  end

  def self.with_user user
    detail = user.detail
    with_club detail.area_id, detail.brand_id
  end

  def apply_president user
    user_id = Share::Userable.get_id user
    president_candidate_ids << user_id
    president_candidate_ids.uniq!
  end

  def apply_mechanic user
    user_id = Share::Userable.get_id user
    mechanic_candidate_ids << user_id
    mechanic_candidate_ids.uniq!
  end

  def appoint_president user
    user_id = Share::Userable.get_id user
    president_id = user_id
  end

  def appoint_mechanic user
    user_id = Share::Userable.get_id user
    mechanic_ids << user_id
    mechanic_ids.uniq!
  end

  def apply_president! user
    apply_president user && save(validate: false)
  end

  def apply_mechanic! user
    apply_mechanic user && save(validate: false)
  end

  def appoint_president! user
    appoint_president user && save(validate: false)
  end

  def appoint_mechanic! user
    appoint_mechanic user && save(validate: false)
  end

  def serializable_hash(options={})
    options = {
      only: [:id, :announcement],
      methods: [:president, :mechanics],
      images: [:avatar]
    }.update(options)
    super(options)
  end
end