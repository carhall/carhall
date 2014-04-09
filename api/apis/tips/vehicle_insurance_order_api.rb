module Tips
  class VehicleInsuranceOrderAPI < Grape::API

    helpers do
      def parent
        current_user.vehicle_insurance_orders.includes(:detail, user: [:detail])
      end
    end

    before do
      authenticate!
    end

    desc <<-DESC
显示当前登录商户的所有车险续保订单

返回数据中user内车型等数据的是车主信息，user外的是订单信息，以订单数据为准
DESC
    get do
      present! parent.with_dealer_state(1)
    end

    desc "显示指定车险续保订单详情"
    get ":id" do
      present! parent.find(params[:id]), type: :detail
    end

    desc "编辑一条车险续保订单"
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