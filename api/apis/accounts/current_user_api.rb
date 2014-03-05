module Accounts
  class CurrentUserAPI < Grape::API

    before do
      authenticate!
    end

    desc "Display the current login user's details."
    get do
      present! current_user, type: :detail
    end
    
  end
end
