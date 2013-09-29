class Api::Tips::ApplicationController < Api::ApplicationController
  before_filter :set_dealer

  def set_dealer
    @dealer = Dealer.find(params[:dealer_id]) if params[:dealer_id]
  end

  def self.set_resource_class klass, options = {}
    before_filter :set_parent

    define_method :set_parent do
      @parent = klass.includes(:dealer, :reviews)
      @parent = @parent.with_dealer @dealer if @dealer
    end

    # GET /api/resources
    # GET /api/resources.json
    define_method :index do
      render_index @parent.scoped
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

    # GET /api/resources/1
    # GET /api/resources/1.json
    define_method :show do
      render_show klass.find(params[:id])
    end
    
    define_method :detail do
      render_show klass.find(params[:id]), :detail
    end
  end
  
end
