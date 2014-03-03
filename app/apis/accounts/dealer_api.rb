module Accounts
  class DealerAPI < Grape::API

    desc "List infos"
    get do
      present! Accounts::Dealer.all
    end

    desc "Show detail"
    get ":id" do
      present! Accounts::Dealer.find(params[:id]), type: :detail
    end
    
  end
end
