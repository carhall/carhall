class Category::Brand2 < ActiveRecord::Base
  include Share::Categoryable

  belongs_to :brand

  extend Share::ImageAttachments
  define_image_method

  validates_presence_of :brand_id, :image 
end