class Api::ReviewsController < Api::ApplicationController
  before_filter :set_parent

  # GET /api/resources/1/reviews
  # GET /api/resources/1/reviews.json
  def index
    render_index @parent.reviews
  end

  # GET /api/resources/1/reviews/1
  # GET /api/resources/1/reviews/1.json
  def show
    render_show @parent.reviews.find(params[:id])
  end

  protected

  AccreditedKeys = {
    'mending_id' => ::Tips::Mending,
    'cleaning_id' => ::Tips::Cleaning,
    'bulk_purchasing_id' => ::Tips::BulkPurchasing,
    'dealer_id' => Dealer,
  }

  def set_parent
    params.each do |key, value|
      if AccreditedKeys.keys.include? key
        parent_class = AccreditedKeys[key]
        @parent = parent_class.find(value)
        return
      end
    end
  end
end
