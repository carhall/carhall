class Category::Brand2 < ActiveRecord::Base
  include Share::Categoryable

  belongs_to :brand
  has_many :brand3s

  extend Share::ImageAttachments
  define_image2_method

  validates_presence_of :brand_id, :image 

  def self.with_area_and_brand area_id, brand_id
    return [] if Tips::SellingBrand
      .with_main_area(area_id).count.zero?
    count = Tips::BuyingAdvice
      .with_main_area(area_id)
      .with_brand(brand_id)
      .group(:brand2_id)
      .reorder(nil).count
    where(brand_id: brand_id).sort_by do |brand2|
      count[brand2.id] || 0
    end.reverse!
  end
  
end