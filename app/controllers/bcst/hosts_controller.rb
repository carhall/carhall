class Bcst::HostsController < Bcst::ApplicationController
  set_resource_class Bcst::Host, title: :name

  def bcst_host_params
    params.require(:bcst_host).permit(:name, :description, :avatar, programme_ids: [])
  end
  
end
