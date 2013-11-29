class Dashboard::BulkPurchasing2sController < Dashboard::ApplicationController
  def index
    @bulk_purchasing2s = ::Tips::BulkPurchasing2.in_progress
    
    @bulk_purchasing2s = set_filter_id @bulk_purchasing2s, :bulk_purchasing_type
    @bulk_purchasing2s = set_filter_id @bulk_purchasing2s, :main_area
  end

  def show
    @bulk_purchasing2 = ::Tips::BulkPurchasing2.find(params[:id])
  end
  
end
