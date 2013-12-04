class Tips::VipCardsController < Tips::ApplicationController
  set_resource_class ::Tips::VipCard

  alias_method :reenable, :expose
  alias_method :disable, :hide

  def tips_vip_card_params
    params.require(:tips_vip_card).permit(:title, :vip_price, :description, :image,
      vip_card_items_attributes: [:id, :_destroy, :title, :count])
  end

end
