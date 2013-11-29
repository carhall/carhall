class Dashboard::PurchaseRequestingsController < Dashboard::ApplicationController
  def index
    @purchase_requestings = ::Tips::PurchaseRequesting.in_progress
    
    @purchase_requestings = set_filter_id @purchase_requestings, :purchase_requesting_type
    @purchase_requestings = set_filter_id @purchase_requestings, :main_area
  end

  def show
    @purchase_requesting = ::Tips::PurchaseRequesting.find(params[:id])
  end

end
