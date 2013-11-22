class Business::AdTemplate < ActiveRecord::Base
  enumerate :product_type, with: %w(洗车 清洗 美容 用品 太阳膜 保养 电子产品 轮胎 换油 维修 配件 汽车 菜单 其它)
  enumerate :product, with: Category::Product
 
  extend Share::ImageAttachments
  define_avatar_method

  has_attached_file :file

  validates_presence_of :avatar, :file
  validates_presence_of :title, :product_id, :product_type_id, :price
  
  def buy user
    if user.detail.balance_used <= user.adverts_balance
      user.detail.balance_used += price
      user.save
    end
  rescue
    nil
  end

end