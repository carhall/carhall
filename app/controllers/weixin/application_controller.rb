class Weixin::ApplicationController < ApplicationController
  skip_before_filter :authenticate_account!
  layout "weixin"

  def self.set_resource_class klass, options = {}
    super klass, options.reverse_merge(no_authorize: true)
  end

end