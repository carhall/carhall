module Accounts
  class LoginAPI < Grape::API

    desc "使用手机号和密码登录"
    params do
      requires :data do
        requires :mobile, type: Integer, desc: '手机号'
        requires :password, type: String, desc: '密码'
      end
    end
    post :login do
      user = Accounts::Account.find_for_database_authentication(mobile: params[:data][:mobile])

      if user && user.valid_password?(params[:data][:password])
        user.ensure_authentication_token!
        present! user, type: :detail, detail_type: :login
      else
        error! '401 Unauthorized', 401
      end
    end

  end
end