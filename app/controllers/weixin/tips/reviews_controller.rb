class Weixin::Tips::ReviewsController < Weixin::ApplicationController
  load_resource :mending, class: Tips::Mending
  load_resource :cleaning, class: Tips::Cleaning
  load_resource :bulk_purchasing, class: Tips::BulkPurchasing
  load_resource :vip_card, class: Tips::VipCard

  def index
    @source = @mending || @cleaning || @bulk_purchasing || @vip_card
    @reviews = @source.reviews
  end
end