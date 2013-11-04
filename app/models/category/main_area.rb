class Category::MainArea < ActiveEnum::Base
  MainAreas = Category::Area::AreaMap.keys

  value MainAreas

end