class Weixin::Statistic::ConsumptionRecordsController < Weixin::ApplicationController
  before_filter :authenticate_account!
  before_filter :set_current_user
  set_resource_class ::Statistic::ConsumptionRecord, through: :user

end