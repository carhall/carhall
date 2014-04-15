class Weixin::ApplicationController < ApplicationController
  skip_before_filter :authenticate_account!
  layout "weixin"

  def self.set_resource_class klass, options = {}
    load_resource :dealer, class: Accounts::Dealer
    super klass, options.reverse_merge(no_authorize: true, through: :dealer)
  end

end