module Accounts
  class DealerAPI < Grape::API

    desc "显示指定商户详情"
    get ":id" do
      present! Accounts::Dealer.find(params[:id]), type: :detail
    end
    
  end
end
