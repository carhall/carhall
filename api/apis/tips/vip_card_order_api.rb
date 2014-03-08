module Tips
  class VipCardOrderAPI < Grape::API

    helpers do
      def parent
        current_user.vip_card_orders.includes(:user)
      end
    end

    before do
      authenticate!
    end

    desc "显示当前登录商户的所有会员卡订单"
    get do
      present! parent
    end

    desc "显示指定会员卡订单详情"
    get ":id" do
      present! parent.find(params[:id]), type: :detail
    end

    desc "通过手机号或车牌号搜索车主会员卡订单"
    params do
      requires :query, type: String, desc: '手机号或车牌号'
    end
    post :search do
      present! parent.with_query params[:query]
    end

    desc <<-DESC
设置会员卡订单使用次数

> 例如：
> ```
> POST /assistant/vip_card_orders/1/use
> data[1]   1
> data[2]   2
> ```
DESC
    params do
      requires :data, type: Hash, desc: "key为会员卡订单服务项目ID，value为使用次数"
    end
    post ":id/use" do
      vip_card_order = parent.find(params[:id])
      vip_card_order.items.each do |item|
        count = params[:data][item.id].to_i
        item.use count if count
      end
      if vip_card_order.save
        present! vip_card_order, type: :detail
      else
        failure! vip_card_order
      end
    end

  end
end