class Dashboard::BulkPurchasing2OrdersController < Dashboard::ApplicationController
  def new
    @bulk_purchasing2 = ::Tips::BulkPurchasing2.find(params[:bulk_purchasing2_id])
    @bulk_purchasing2_order = @bulk_purchasing2.orders.new
  end

  def create
    @bulk_purchasing2 = ::Tips::BulkPurchasing2.find(params[:bulk_purchasing2_id])
    order = @bulk_purchasing2.orders.new(params.require(:tips_bulk_purchasing2_order).permit(:count))
    order.dealer = @current_user
    if order.save
      flash[:success] = I18n.t('book_success')
      redirect_to dashboard_bulk_purchasing2_path(@bulk_purchasing2)
    else
      render 'new'
    end
  end

end