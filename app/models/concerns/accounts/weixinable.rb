module Accounts::Weixinable
  extend ActiveSupport::Concern
  extend WeixinHelper

  def update_weixin
    Accounts::Weixinable.initialize_weixin_account self
  end

  module ClassMethods

    def update_weixin
      all.each do |account|
        if account.weixin_app_id
          Accounts::Weixinable.initialize_weixin_account account
        end
      end
    end

  end
end
