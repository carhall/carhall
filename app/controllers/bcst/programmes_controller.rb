class Bcst::ProgrammesController < Bcst::ApplicationController
  set_resource_class Bcst::Programme

  def data_params
    params.require(:bcst_programme).permit(:title, :description, :avatar, host_ids: [])
  end
  
end
