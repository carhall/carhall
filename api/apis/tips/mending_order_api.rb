module Tips
  class MendingOrderAPI < Grape::API

    helpers do
      def parent
        current_user.mending_orders.includes(:detail, user: [:detail])
      end
    end

    before do
      authenticate!
    end

    desc "显示当前登录商户的所有保养专修订单"
    get do
      present! parent.with_dealer_state(1)
    end

    desc "显示指定保养专修订单详情"
    get ":id" do
      present! parent.find(params[:id]), type: :detail
    end

    desc "编辑一条保养专修订单"
    params do
      requires :data do
        requires :dealer_state_id, type: Integer, desc: '状态ID：1.跟踪 2.解决'
      end
    end
    put ":id" do
      record = parent.find(params[:id])
      record.update(declared(params)[:data])
      if record.save
        present! record, type: :detail
      else
        failure! record
      end
    end

  end
end