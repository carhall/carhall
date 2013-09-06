class Tips::MendingsController < Tips::ApplicationController
  set_resource_class Mending, singleton: true, orders: true

  alias_method :edit_discount, :edit
  alias_method :edit_brands, :edit

end
