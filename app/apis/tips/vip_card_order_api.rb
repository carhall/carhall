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

    desc "List infos"
    get do
      present! parent
    end

    desc "Show detail"
    get ":id" do
      present! parent.find(params[:id]), type: :detail
    end

    desc "Search by mobile and plate_num."
    params do
      requires :query, type: String
    end
    post :search do
      present! parent.with_query params[:query]
    end

    desc "Set used_count"
    params do
      requires :data, type: Hash
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