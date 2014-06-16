class Tips::SellingBrand < ActiveRecord::Base
  include Share::Dealerable
  
  enumerate :brand, with: Category::Brand

end
