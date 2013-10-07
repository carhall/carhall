class Api::Bcst::ProgrammesController < Api::Bcst::ApplicationController
  set_resource_class ::Bcst::Programme
  
  def set_parent
    @parent = ::Bcst::Programme.includes(:hosts)
    @parent = @parent.with_provider @provider if @provider
  end

end
