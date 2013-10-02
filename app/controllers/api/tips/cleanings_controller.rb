class Api::Tips::CleaningsController < Api::Tips::ApplicationController
  set_resource_class ::Tips::Cleaning

  def set_filter
    super
    filter_parent :cleaning_type
  end

end
