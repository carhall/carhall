class PurchaseRequestingsController < ApplicationController
  def index
    @purchase_requestings = ::Tips::PurchaseRequesting.in_progress
    
    @purchase_requesting_type_id = params[:purchase_requesting_type_id].to_i if params[:purchase_requesting_type_id]
    @purchase_requestings = @purchase_requestings.with_purchase_requesting_type(@purchase_requesting_type_id) if @purchase_requesting_type_id

    @main_area_id = params[:main_area_id].to_i if params[:main_area_id]
    @purchase_requestings = @purchase_requestings.with_main_area(@main_area_id) if @main_area_id
  end


  def show
    @purchase_requesting = ::Tips::PurchaseRequesting.find(params[:id])
  end

end
