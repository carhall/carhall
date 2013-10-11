class Tips::ApplicationController < ApplicationController
  before_filter :set_dealer

  def self.set_resource_class klass, options = {}
    super klass, options

    if options[:expiredable] and not options[:singletion]
      define_method :expired do
        self.collection_instance = collection_instance.expired
      end

      define_method :in_progress do
        self.collection_instance = collection_instance.in_progress
      end
    end

    define_method :expose do
      service = resource_instance
      service.expose!
      redirect_to :back
    end
    define_method :hide do
      service = resource_instance
      service.hide!
      redirect_to :back
    end

    define_method :stick do
      service = resource_instance
      service.stick!
      redirect_to :back
    end
    define_method :unstick do
      service = resource_instance
      service.unstick!
      redirect_to :back
    end

    # GET /api/resources/orders
    # GET /api/resources/orders.json
    define_method :orders do
      @orders = @dealer.send("#{klass.name.demodulize.underscore}_orders")
    end if options[:orders]


  end

end