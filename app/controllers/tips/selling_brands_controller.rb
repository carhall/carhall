class Tips::SellingBrandsController < Tips::ApplicationController
  before_filter :load_selling_brand, except: :index
  set_resource_class Tips::SellingBrand, singleton: true

  def after_update_path
    tips_root_path
  end

private

  def tips_selling_brand_params
    params.require(:tips_selling_brand).permit(:brand_id)
  end

  def load_selling_brand
    @selling_brand = @dealer.selling_brand || @dealer.create_selling_brand
  end
  
end
