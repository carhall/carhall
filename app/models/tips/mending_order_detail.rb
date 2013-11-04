class Tips::MendingOrderDetail < ActiveRecord::Base
  enumerate :brand, with: Category::Brand

  # validates_presence_of :brand_id, :series, :plate_num, :arrive_at, :mending_type_id

  enumerate :mending_type, with: %w(标准保养 维修)

  def to_base_builder
    Jbuilder.new do |json|
      json.extract! self, :brand_id, :brand, :series, :plate_num, :arrive_at, 
        :mending_type_id, :mending_type, :description
    end
  end

end
