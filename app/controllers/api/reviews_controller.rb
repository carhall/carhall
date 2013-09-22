class Api::ReviewsController < Api::ApplicationController
  before_filter :set_parent

  set_resource_class Review
  attr_reader :parent

  protected

  AccreditedKeys = {
    'mending_id' => Mending,
    'cleaning_id' => Cleaning,
    'bulk_purchasing_id' => BulkPurchasing,
    'dealer_id' => Dealer,
  }

  def set_parent
    params.each do |key, value|
      if AccreditedKeys.keys.include? key
        parent_class = AccreditedKeys[key]
        @parent = parent_class.find(value).reviews
        return
      end
    end
  end
end
