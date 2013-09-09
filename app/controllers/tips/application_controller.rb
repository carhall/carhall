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
          redirect_to tips_root_path, flash: { success: i18n_message(:update_success_without_title, klass.name.underscore) }
        else
          render :edit
        end
      end

    else # singletion

      define_method :index do
        @tips = @parent
      end

      if options[:expiredable]
        define_method :expired do
          @tips = @parent.expired
        end

        define_method :in_progress do
          @tips = @parent.in_progress
        end
      end

      define_method :new do
        @tip = @parent.new
      end

      define_method :create do
        @tip = @parent.new params[klass.name.underscore]

        if @tip.save
          index_path = { action: :index }
          redirect_to index_path, flash: { success: i18n_message(:create_success, klass.name.underscore) }
        else
          render :new
        end
      end

      define_method :update do
        @tip = @parent.find(params[:id])

        if @tip.update_attributes(params[klass.name.underscore])
          index_path = { action: :index }
          redirect_to index_path, flash: { success: i18n_message(:update_success, klass.name.underscore) }
        else
          render :new
        end
      end

      define_method :edit do
        @tip = @parent.find(params[:id])
      end

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
      @orders = @dealer.send("#{klass.name.underscore}_orders")
    end if options[:orders]

  end

  def i18n_message message_type, model
    options = { model: I18n.t(model, scope: 'activerecord.models') }
    options[:title] = @tip.title if @tip.respond_to? :title
    I18n.t(message_type, options)
  end

end