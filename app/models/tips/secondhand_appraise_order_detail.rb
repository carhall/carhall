class Tips::SecondhandAppraiseOrderDetail < ActiveRecord::Base
  enumerate :brand, with: Category::Brand

  validates_presence_of :brand_id, :series, :plate_num, :purchasing_date, :travelling_miles

end
