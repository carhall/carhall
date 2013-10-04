class Api::Bcst::ProgrammeListsController < Api::Bcst::ApplicationController
  set_resource_class ::Bcst::ProgrammeList

  def show
    programme_list = @provider.programme_list_as_api_response
    render_data programme_list
  end

end
