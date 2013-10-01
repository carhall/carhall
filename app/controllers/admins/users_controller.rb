class Admins::UsersController < Admins::ApplicationController
  set_resource_class Accounts::User
  
end