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
      present! user_info(query), with: Statistic::UserInfoEntity
    end

  end
end