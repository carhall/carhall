class Bcst::ApplicationController < ApplicationController
  prepend_before_filter :ensure_user_type
  before_filter :set_provider

  def self.set_resource_class klass, options = {}
    before_filter :set_parent

    respond_to :html

    if options[:singleton]

      define_method :edit do
        @bcst = @parent || klass.create(provider: @provider)
      end

      define_method :update do
        @bcst = @parent || klass.new(provider: @provider)

        if @bcst.update_attributes(data_params)
          show_path = { action: :show }
          redirect_to show_path, flash: { success: i18n_message(:update_success_without_title, klass.name.underscore) }
        else
          render :edit
        end
      end

      define_method :set_parent do
        @parent = @provider.send(klass.name.demodulize.underscore)
      end

    else # singletion
      before_filter :set_resource, only: [:show, :edit, :update, :destroy]

      define_method :index do
        @bcsts = @parent
      end

      define_method :show do
      end

      define_method :new do
        @bcst = @parent.new
      end

      define_method :create do
        @bcst = @parent.new data_params

        if @bcst.save
          index_path = { action: :index }
          redirect_to index_path, flash: { success: i18n_message(:create_success, klass.name.underscore) }
        else
          render :new
        end
      end

      define_method :edit do
      end

      define_method :update do
        if @bcst.update_attributes(data_params)
          index_path = { action: :index }
          redirect_to index_path, flash: { success: i18n_message(:update_success, klass.name.underscore) }
        else
          render :edit
        end
      end

      define_method :destroy do
        @bcst.destroy

        index_path = { action: :index }
        redirect_to index_path, flash: { success: i18n_message(:destroy_success, klass.name.underscore) }
      end

      define_method :set_parent do
        @parent = @provider.send(klass.name.demodulize.tableize)
      end

      define_method :set_resource do
        @bcst = @parent.find(params[:id])
      end

    end # singletion

  end

  def i18n_message message_type, model
    options = { model: I18n.t(model, scope: 'activerecord.models') }
    options[:title] = @bcst.title if @bcst.respond_to? :title
    I18n.t(message_type, options)
  end

end