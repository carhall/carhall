class Api::Bcst::ApplicationController < Api::ApplicationController
  before_filter :set_provider

  def set_provider
    @provider = ::Accounts::Provider.find(params[:provider_id]) if params[:provider_id]
  end

  def self.set_resource_class klass, options = {}
    super klass, options.reverse_merge(detail: true)

    define_method :set_parent do
      @parent = klass.all
      @parent = @parent.with_provider @provider if @provider
    end
  end
  
end