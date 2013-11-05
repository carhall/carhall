# class BulkPurchasing2sController < ApplicationController
#   def index
#     @bulk_purchasing2s = ::Tips::BulkPurchasing2.in_progress
    
#     @bulk_purchasing_type_id = params[:bulk_purchasing_type_id].to_i if params[:bulk_purchasing_type_id]
#     @bulk_purchasing2s = @bulk_purchasing2s.with_bulk_purchasing_type(@bulk_purchasing_type_id) if @bulk_purchasing_type_id

#     @main_area_id = params[:main_area_id].to_i if params[:main_area_id]
#     @bulk_purchasing2s = @bulk_purchasing2s.with_main_area(@main_area_id) if @main_area_id
#   end


#   def show
#     @bulk_purchasing2 = ::Tips::BulkPurchasing2.find(params[:id])
#   end
  
# end
