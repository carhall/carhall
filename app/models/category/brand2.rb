class Category::Brand2 < ActiveRecord::Base
  include Share::Categoryable

  belongs_to :brand
  has_many :brand3s

  extend Share::ImageAttachments
  define_image2_method

  validates_presence_of :brand_id, :image 

  def self.with_area_and_brand main_area_id, brand_id
    main_area_id = main_area_id.to_i
    area_ids = (main_area_id*100)..(main_area_id*100+99)
    brand3_ids = Category::Brand.find(brand_id).brand3_ids
    count = Tips::BuyingAdvice.joins(:user, :brand3)
      .where("`accounts`.`area_id` IN (?)", area_ids)
      .where(brand3_id: brand3_ids)
      .group("`brand3s`.`brand2_id`")
      .reorder("`buying_advices`.`id`")
      .count
    where(brand_id: brand_id).sort_by do |brand2|
      count[brand2.id] || 0
    end.reverse!
  end
end