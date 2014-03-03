module Accounts
  class DealerAPI < Grape::API

    desc "Display the specified dealer's details."
    get ":id" do
      present! Accounts::Dealer.find(params[:id]), type: :detail
    end
    
  end
end
