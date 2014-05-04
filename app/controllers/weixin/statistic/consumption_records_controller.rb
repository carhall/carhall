class Weixin::Statistic::ConsumptionRecordsController < Weixin::ApplicationController
  before_filter :authenticate_account!
  before_filter :set_current_user

  def index
    @consumption_records = @user.consumption_records
  end

end