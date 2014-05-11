module Share::Areable
  extend ActiveSupport::Concern

  included do
    enumerate :area, with: Category::Area
    alias_method :city, :area
    alias_method :main_area, :province

    scope :with_main_area, -> (area_id) { 
      where(area_id: (area_id*100)..(area_id*100+99)) 
    }
  end

  def main_area_id
    (area_id||0)/100
  end
  
  def main_area_range
    (main_area_id*100)..(main_area_id*100+99)
  end

  def province
    area(:province)
  end

end