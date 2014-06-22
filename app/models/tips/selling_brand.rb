class Tips::SellingBrand < ActiveRecord::Base
  include Share::Dealerable
  
  belongs_to :brand, class_name: 'Category::Brand'
  alias_method :rbrand, :brand

  enumerate :main_area, with: Category::Area::Main
  enumerate :brand, with: Category::Brand

  before_save do
    self.main_area_id = dealer.main_area_id
  end

end
