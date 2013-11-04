class DistributorsController < ApplicationController
  def index
    @distributors = Accounts::Distributor.all

    @business_scope_id = params[:business_scope_id].to_i if params[:business_scope_id]
    @distributors = @distributors.with_business_scope(@business_scope_id) if @business_scope_id

    @main_area_id = params[:main_area_id].to_i if params[:main_area_id]
    @distributors = @distributors.with_main_area(@main_area_id) if @main_area_id

    @product_id = params[:product_id].to_i if params[:product_id]
    @distributors = @distributors.with_product(@product_id) if @product_id
  end
end
