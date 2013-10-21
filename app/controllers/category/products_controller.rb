class Category::ProductsController < Category::ApplicationController
  set_resource_class Category::Product
  
  def category_product_params
    params.require(:category_product).permit(:name)
  end

end