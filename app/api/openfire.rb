module Openfire
  class API < Grape::API
    version 'v1', using: :param
    format :json
    helpers RenderHelper

    error_formatter :json, ErrorFormatter
    formatter :json, DataFormatter

    desc "Login by mobile and password."
    params do
      requires :mobile, type: Integer
      requires :password, type: String
    end
    post :login do
      @user = ::Accounts::Account.find_for_database_authentication(mobile: params[:mobile])

      if @user && @user.valid_password?(params[:password])
        @user.ensure_authentication_token!
        present @user, with: ::Accounts::OpenfireAccountEntity, type: :login
      else
        error! '401 Unauthorized', 401
      end
    end

    desc "Login by authentication token."
    params do
      requires :token, type: String
    end
    post :login_by_token do
      @user = ::Accounts::Account.find_by(authentication_token: params[:token])

      if @user
        present @user, with: ::Accounts::OpenfireAccountEntity, type: :login
      else
        error! '401 Unauthorized', 401
      end
    end

    desc "Get user"
    params do
      requires :id, type: Integer
    end
    post :get_user do
      @user = ::Accounts::Account.find(params[:id])
      present @user, with: ::Accounts::OpenfireAccountEntity, type: :detail
    end

    desc "List users"
    params do
      requires :ids, type: String
    end
    post :list_users do
      @users = ::Accounts::Account.find(params[:ids].split(','))
      present @users, with: ::Accounts::OpenfireAccountEntity, type: :detail
    end

    desc "Send media file"
    params do
      requires :imres
      requires :type, type: Integer
    end
    post :send_file do
      @upload = ::Share::Upload.new(file: params[:imres], type_id: params[:type])

      if @upload.save
        { filePath: "#{AbsoluteUrlPrefix}#{@upload.file.url}" }
      else
        failure! @upload
      end
    end
  end
end
