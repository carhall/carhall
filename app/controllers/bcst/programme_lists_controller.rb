class Bcst::ProgrammeListsController < Bcst::ApplicationController
  set_resource_class Bcst::ProgrammeList

  def new
    @bcst = @parent.new
    @bcst.day = params[:day]
  end

  def data_params
    params.require(:bcst_programme_list).permit(:airdate, :title, :description, :day)
  end
  
end
