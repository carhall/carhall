class Business::Tutorial < ActiveRecord::Base
  enumerate :product_type, with: %w(洗车 清洗 美容 用品 太阳膜 保养 电子产品 轮胎 换油 维修 配件 其它)
  enumerate :product, with: Category::Product
 
  extend Share::ImageAttachments
  define_avatar_method

  # has_attached_file :file

  validates_presence_of :avatar
  validates_presence_of :title, :product_id, :product_type_id, :url

  has_many :distributor_infos, dependent: :destroy
  accepts_nested_attributes_for :distributor_infos, allow_destroy: true
  
end