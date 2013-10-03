class Bcst::ExposuresController < Bcst::CommentsController

private

  def set_parent
    @parent = @provider.exposures
  end
  
end