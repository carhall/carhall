class Category::Brand3sController < Category::ApplicationController
  set_resource_class Category::Brand3
  
  def category_brand3_params
    params.require(:category_brand3).permit(:name, :brand2_id, :image)
  end

end