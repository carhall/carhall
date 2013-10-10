class Bcst::ProgrammeListsController < Bcst::ApplicationController
  set_resource_class Bcst::ProgrammeList

  def new
    @programme_list.day = params[:day]
  end

  def bcst_programme_list_params
    params.require(:bcst_programme_list).permit(:airdate, :title, :description, :day)
  end
  
end
