class Tips::SellingBrand < ActiveRecord::Base
  include Share::Dealerable
  
  belongs_to :brand, class_name: 'Category::Brand'
  alias_method :rbrand, :brand

  enumerate :brand, with: Category::Brand

end
