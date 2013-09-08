class Club < ActiveRecord::Base
  include Share::Areable
  include Share::Brandable

  belongs_to :president, class_name: "BaseUser"
  has_many :posts

  extend Share::Ids2Users
  define_ids_2_users_methods :president_candidates
  define_ids_2_users_methods :mechanics
  define_ids_2_users_methods :mechanic_candidates
  
  attr_accessible :area_id, :brand_id, :announcement, :avatar

  def self.with_club area_id, brand_id
    where(area_id: area_id, brand_id: brand_id).first_or_create
  end

  def self.with_user user
    raise CanCan::AccessDenied unless user.user_type == :user
    detail = user.detail
    with_club detail.area_id, detail.brand_id
  end

  def apply_president user
    club.president_candidate_ids << user.id
    club.president_candidate_ids.unique!
  end

  def apply_mechanic user
    club.mechanic_candidate_ids << user.id
    club.mechanic_candidate_ids.unique!
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