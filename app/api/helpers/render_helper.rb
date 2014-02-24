module Helpers::RenderHelper
  def failure!(resource)
    error! resource.errors.full_messages.first, 422
  end
end