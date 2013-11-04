module Share::Areable
  extend ActiveSupport::Concern

  included do
    enumerate :area, with: Category::Area
    alias_method :city, :area
    alias_method :main_area, :province

    scope :with_main_area, -> (main_area_id) { 
      where(area_id: (main_area_id*100)..(main_area_id*100+99)) 
    }
  end
  
  def province
    area(:province)
  end

end