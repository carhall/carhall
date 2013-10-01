class Api::Tips::ReviewsController < Api::ApplicationController
  set_resource_class Review

  protected

  AccreditedKeys = {
    'mending_id' => Mending,
    'cleaning_id' => Cleaning,
    'bulk_purchasing_id' => BulkPurchasing,
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
