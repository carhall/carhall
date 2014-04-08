module Statistic
  class ConsumptionRecordAPI < Grape::API

    helpers do
      def parent
        parent = current_user.consumption_records
        parent = parent.with_user(params[:user_id]) if params[:user_id]
        parent
      end
    end

    before do
      authenticate!
    end

    desc "显示当前登录商户的该用户的所有消费记录"
    get do
      present! parent
    end

  end
end