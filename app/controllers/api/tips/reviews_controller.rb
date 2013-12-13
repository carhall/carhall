class Api::Tips::ReviewsController < Api::ApplicationController
  before_filter :set_current_user
  set_resource_class ::Tips::Review
  before_filter :set_includes, only: :index

  protected

  AccreditedKeys = {
    'mending_id' => ::Tips::Mending,
    'cleaning_id' => ::Tips::Cleaning,
    'bulk_purchasing_id' => ::Tips::BulkPurchasing,
    'vip_card_id' => ::Tips::VipCard,
    'dealer_id' => ::Accounts::Dealer,
  }

  def set_parent
    params.each do |key, value|
      if AccreditedKeys.keys.include? key
        parent_class = AccreditedKeys[key]
        @parent = parent_class.find(value).reviews
        return
      end
    end
    @parent = @current_user.reviews
  end
  
  def set_includes
    @parent = @parent.includes(order: [:user])
  end

end
