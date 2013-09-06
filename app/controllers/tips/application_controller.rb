class Tips::ApplicationController < ApplicationController
  ensure_base_user_type :dealer
  # ensure_base_user_accepted

  def self.set_resource_class klass, options = {}
    before_filter :set_dealer
    before_filter :set_parent

    respond_to :html

    if options[:singleton]

      define_method :edit do
        @tip = @parent || klass.create(dealer: @dealer)
      end

      define_method :set_parent do
        @parent = @dealer.send(klass.name.underscore)
      end

      define_method :update do
        @tip = @parent || klass.new(dealer: @dealer)

        if @tip.update_attributes(params[klass.name.underscore])
          redirect_to tips_root_path, flash: { success: i18n_message(:update_success, klass.name.underscore) }
        else
          render :edit
        end
      end

    else # singletion

      # GET /api/resources
      # GET /api/resources.json
      define_method :index do
        @tips = @parent
      end

      define_method :new do
        @tip = @parent.new
      end

      # GET /api/resources/1
      # GET /api/resources/1.json
      define_method :show do
        @tip = @parent.find(params[:id])
      end

      define_method :set_parent do
        @parent = @dealer.send(klass.name.tableize)
      end

    end # singletion

    # GET /api/resources/orders
    # GET /api/resources/orders.json
    define_method :orders do
      @parent = @dealer.send("#{klass.name.underscore}_orders")
    end if options[:orders]

  end

  def i18n_message message_type, model
    I18n.t(message_type, model: I18n.t(model, scope: 'activerecord.models'))
  end

  protected
  
  def set_dealer
    @dealer = Dealer.find(@user.id)
  end
end