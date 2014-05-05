class Weixin::Statistic::SalesCasesController < Weixin::ApplicationController
  before_filter :authenticate_weixin_account!
  before_filter :set_weixin_current_user

  def index
    @sales_cases = @user.sales_cases
  end

end