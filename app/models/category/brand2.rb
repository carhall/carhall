class Category::Brand2 < ActiveRecord::Base
  include Share::Categoryable

  belongs_to :brand
  has_many :brand3s

  extend Share::ImageAttachments
  define_image2_method

  validates_presence_of :brand_id, :image 

  def self.with_area_and_brand main_area_id, brand_id
    main_area_id = main_area_id.to_i
    brand_id = brand_id.to_i
    buying_advices = Tips::BuyingAdvice.joins(:brand3)
    brand2s = all

    unless main_area_id.zero?
      area_ids = (main_area_id*100)..(main_area_id*100+99)
      buying_advices = buying_advices.joins(:user)
        .where("`accounts`.`area_id` IN (?)", area_ids)
    end

    unless brand_id.zero?
      brand3_ids = Category::Brand.find(brand_id).brand3_ids
      buying_advices = buying_advices.where(brand3_id: brand3_ids)
      brand2s = brand2s.where(brand_id: brand_id)
    end
      
    count = buying_advices
      .group("`brand3s`.`brand2_id`")
      .reorder("count_all")
      .count

    brand2s.sort_by do |brand2|
      count[brand2.id] || 0
    end.reverse!
  end
end