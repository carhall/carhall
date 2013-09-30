class Tips::ApplicationController < ApplicationController
  prepend_before_filter :ensure_user_type

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

        if @tip.update_attributes(data_params)
          redirect_to tips_root_path, flash: { success: i18n_message(:update_success_without_title, klass.name.underscore) }
        else
          render :edit
        end
      end

    else # singletion
      before_filter :set_resource, only: [:show, :edit, :update, :destroy]

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

      define_method :show do
      end

      define_method :new do
        @tip = @parent.new
      end

      define_method :create do
        @tip = @parent.new data_params

        if @tip.save
          index_path = { action: :index }
          redirect_to index_path, flash: { success: i18n_message(:create_success, klass.name.underscore) }
        else
          render :new
        end
      end

      define_method :edit do
      end

      define_method :update do
        if @tip.update_attributes(data_params)
          index_path = { action: :index }
          redirect_to index_path, flash: { success: i18n_message(:update_success, klass.name.underscore) }
        else
          render :edit
        end
      end

      define_method :destroy do
        @tip.destroy

        index_path = { action: :index }
        redirect_to index_path, flash: { success: i18n_message(:destroy_success, klass.name.underscore) }
      end

      define_method :set_parent do
        @parent = @dealer.send(klass.name.tableize)
      end

      define_method :set_resource do
        @tip = @parent.find(params[:id])
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