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

    # GET /api/resources/orders
    # GET /api/resources/orders.json
    define_method :orders do
      @orders = @dealer.send("#{klass.name.demodulize.underscore}_orders")
    end if options[:orders]


  end

end