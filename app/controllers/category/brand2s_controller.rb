class Category::Brand2sController < Category::ApplicationController
  set_resource_class Category::Brand2
  
  def category_brand2_params
    params.require(:category_brand2).permit(:name, :brand_id, :image)
  end

end