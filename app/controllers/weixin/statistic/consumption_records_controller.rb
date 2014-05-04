class Weixin::Statistic::ConsumptionRecordsController < Weixin::ApplicationController
  before_filter :authenticate_weixin_account!
  before_filter :set_weixin_current_user

  def index
    @consumption_records = @user.consumption_records
  end

end