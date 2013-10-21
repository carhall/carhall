class Category::BrandsController < Category::ApplicationController
  set_resource_class Category::Brand
  
  def category_brand_params
    params.require(:category_brand).permit(:name)
  end

end