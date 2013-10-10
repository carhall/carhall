class Statistic::UsersController < Statistic::ApplicationController
  load_and_authorize_resource class: ::Accounts::User
  
end