class Tips::MendingOrderDetail < ActiveRecord::Base
  enumerate :brand, with: Category::Brand

  validates_presence_of :brand_id, :series, :plate_num, :arrive_at, :mending_type_id

  enumerate :mending_type, with: %w(标准保养 维修)

  acts_as_api

  api_accessible :base do |t|
    t.only :brand_id, :series, :plate_num, :arrive_at, :mending_type_id, :description
    t.methods :brand, :mending_type
  end

end
