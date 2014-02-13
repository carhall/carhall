class Statistic::SalesCasesController < Statistic::ApplicationController
  set_resource_class ::Statistic::SalesCase

  def new
    @sales_case.user_id = params[:user_id]
  end

  def create
    if @sales_case.save
      flash[:success] = i18n_message(:create_success_without_title)
      redirect_to statistic_user_friends_path
    else
      render :new
    end
  end

  def update
    if @sales_case.update_attributes params[:statistic_sales_case]
      flash[:success] = i18n_message(:update_success_without_title)
      redirect_to statistic_user_friends_path
    else
      render :edit
    end
  end

  def statistic_sales_case_params
    params.require(:statistic_sales_case).permit(:user_id, :description, :solution, :provider)
  end

end