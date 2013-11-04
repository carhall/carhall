class Tips::Activity < ActiveRecord::Base
  include Tips::Servicable

  extend Share::ImageAttachments
  define_image_method

  enumerate :area, with: Category::Area
  include Share::Localizable
  
  validates_presence_of :title, :expire_at

  include Tips::Expiredable
  scope :ordered, -> { displayed.positioned.in_progress }

  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :id, :title, :expire_at, :area_id, :area, :description
      json.image! self, :image
    end
  end

  def to_detail_builder
    json = to_base_builder
    json.builder! self, :dealer, :detail_without_statistic
    json
  end

end
