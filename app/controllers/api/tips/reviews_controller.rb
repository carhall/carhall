class Api::Tips::ReviewsController < Api::ApplicationController
  set_resource_class Tips::Review

  protected

  AccreditedKeys = {
    'mending_id' => Tips::Mending,
    'cleaning_id' => Tips::Cleaning,
    'bulk_purchasing_id' => Tips::BulkPurchasing,
    'dealer_id' => Accounts::Dealer,
  }

  def set_parent
    params.each do |key, value|
      if AccreditedKeys.keys.include? key
        parent_class = AccreditedKeys[key]
        @parent = parent_class.find(value).reviews
        return
      end
    end
    @parent = current_user.reviews
  end
end
