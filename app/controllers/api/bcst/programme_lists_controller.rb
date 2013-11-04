class Api::Bcst::ProgrammeListsController < Api::Bcst::ApplicationController
  set_resource_class ::Bcst::ProgrammeList

  def show
    programme_list = @provider.to_programme_list_builder
    render_data programme_list
  end

end
