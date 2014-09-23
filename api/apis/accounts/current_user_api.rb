module Accounts
  class CurrentUserAPI < Grape::API

    before do
      authenticate!
    end

    desc "显示当前登录用户详情"
    get do
      present! current_user, type: :detail
    end

    
  end
end
