class Tips::ConstructionCasesController < Tips::ApplicationController
  set_resource_class Tips::ConstructionCase

  def tips_construction_case_params
    params.require(:tips_construction_case).permit(:image, :title, :brand_id)
  end

end
