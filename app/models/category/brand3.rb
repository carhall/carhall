class Category::Brand3 < ActiveRecord::Base
  include Share::Categoryable

  belongs_to :brand2
  belongs_to :brand

  extend Share::ImageAttachments
  define_image_method

  validates_presence_of :brand2_id

  before_save do
    self.brand_id = brand2.brand_id
    self.image = brand2.image if self.image.blank?
  end
end