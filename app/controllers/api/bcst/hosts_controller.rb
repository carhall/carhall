class Api::Bcst::HostsController < Api::Bcst::ApplicationController
  set_resource_class ::Bcst::Host
  
  def set_parent
    @parent = ::Bcst::Host.includes(:programmes)
    @parent = @parent.with_provider @provider if @provider
  end
  
end
