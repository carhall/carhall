class Tips::Activity < ActiveRecord::Base
  include Tips::Servicable

  extend Share::ImageAttachments
  define_image_method

  enumerate :area, with: Category::Area
  include Share::Localizable
  
  validates_presence_of :title, :expire_at

  include Tips::Expiredable
  scope :ordered, -> { displayed.positioned.in_progress }

  api_accessible :base, includes: [:dealer] do |t|
    t.only :id, :title, :expire_at, :area_id, :description
    t.methods :area
    t.images :image
    t.add :dealer, template: :base
  end 

  api_accessible :detail, extend: :base do |t|
    t.add :dealer, template: :detail_without_statistic
  end 

end
