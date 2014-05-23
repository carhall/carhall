class Accounts::UsersController < Accounts::ApplicationController
  skip_before_filter :set_current_user
  set_resource_class Accounts::User

end