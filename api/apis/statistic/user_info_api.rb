module Statistic
  class UserInfoAPI < Grape::API

    before do
      authenticate!
    end

    desc "通过手机号或车牌号搜索用户信息"
    params do
      requires :query, type: String, desc: '手机号或车牌号'
    end
    post :search do
      status 200
      user_infos = Accounts::User.includes(:detail).with_query(params[:query]).to_a
      user_infos += current_user.clients.with_query(params[:query]).to_a
      present! user_infos, with: Statistic::UserInfoEntity
    end

  end
end