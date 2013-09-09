class Club < ActiveRecord::Base
  include Share::Areable
  include Share::Brandable

  belongs_to :president, class_name: "BaseUser"
  has_many :posts

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
    president_candidate_ids << user.id
    president_candidate_ids.uniq!
    save
  end

  def apply_mechanic user
    mechanic_candidate_ids << user.id
    mechanic_candidate_ids.uniq!
    save
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