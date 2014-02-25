class Weixin::ApplicationController < ApplicationController
  skip_before_filter :authenticate_account!

end