class Api::Tips::ApplicationController < Api::ApplicationController
  
  def set_filter
    filter_parent :area
  end

  def set_dealer
    @dealer = ::Accounts::Dealer.find(params[:dealer_id]) if params[:dealer_id]
  end

  def self.set_resource_class klass, options = {}
    super klass, options.reverse_merge(detail: true)
    before_filter :set_filter

    define_method :set_parent do
      @parent = klass.includes(:dealer, :reviews)
      @parent = @parent.with_dealer @dealer if @dealer
    end

    define_method :nearby do
      render_index @parent.with_location params[:lat].to_f, params[:lng].to_f
    end

    define_method :cheapie do
      render_index @parent.cheapie
    end
    
    define_method :favorite do
      render_index @parent.favorite
    end
    
    define_method :hot do
      render_index @parent.hot
    end
  end
  
end
