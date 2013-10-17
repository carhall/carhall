class Api::Bcst::ProgrammesController < Api::Bcst::ApplicationController
  set_resource_class ::Bcst::Programme
  
  def set_parent
    @parent = ::Bcst::Programme
    @parent = @parent.with_provider @provider if @provider
  end

end
