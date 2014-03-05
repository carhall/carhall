module Statistic
  class UserInfoAPI < Grape::API

    before do
      authenticate!
    end

    desc "Search user information by mobile and plate_num."
    params do
      requires :query, type: String
    end
    post :search do
      status 200
      user_infos = Accounts::User.includes(:detail).with_query(params[:query]).to_a
      user_infos += current_user.clients.with_query(params[:query]).to_a
      present! user_infos, with: Statistic::UserInfoEntity
    end

  end
end