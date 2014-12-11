class Tips::FreeTicketsController < Tips::ApplicationController
  set_resource_class Tips::FreeTicket, orders: true, expiredable: true

  def tips_free_ticket_params
    params.require(:tips_free_ticket).permit(:title, :ticket_type_id, 
      :expire_at, :price, :vip_price, :description, :image)
  end

end