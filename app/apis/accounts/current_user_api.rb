module Accounts
  class CurrentUserAPI < Grape::API

    before do
      authenticate!
    end

    desc "Show detail"
    get do
      present! current_user, type: :detail
    end
    
  end
end
