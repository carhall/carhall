class Weixin::Tips::VipCardOrdersController < Weixin::ApplicationController
  before_filter :authenticate_account!
  before_filter :set_current_user
  set_resource_class ::Tips::VipCardOrder, through: :user

end