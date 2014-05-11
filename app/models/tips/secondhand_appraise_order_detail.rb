class Tips::SecondhandAppraiseOrderDetail < ActiveRecord::Base
  enumerate :brand, with: Category::Brand

  validates_presence_of :brand_id, :series, :purchasing_date, :travelling_miles

end
