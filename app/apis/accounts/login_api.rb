module Accounts
  class LoginAPI < Grape::API

    desc "Login by mobile and password."
    params do
      requires :data do
        requires :mobile, type: Integer
        requires :password, type: String
      end
    end
    post :login do
      user = Accounts::Account.find_for_database_authentication(mobile: params[:data][:mobile])

      if user && user.valid_password?(params[:data][:password])
        user.ensure_authentication_token!
        present! user, type: :login
      else
        error! '401 Unauthorized', 401
      end
    end

  end
end