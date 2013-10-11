class ApplicationController < ActionController::Base
  protect_from_forgery

  include FilterHelper
  before_filter :set_current_user
  before_filter :set_user_type

  def self.set_resource_class klass, options = {}
    respond_to :html
    
    before_filter do
      method = "#{namespaced_name}_params"
      params[namespaced_name] &&= send(method) if respond_to?(method, true)
    end

    load_and_authorize_resource options.reverse_merge(class: klass)

    def namespaced_name
      @namespaced_name ||= controller_path.gsub('/', '_').singularize.to_sym
    end

    def instance_name
      @instance_name ||= controller_path.split('/').last.singularize
    end

    def resource_instance
      instance_variable_get("@#{instance_name}")
    end

    def collection_instance
      instance_variable_get("@#{instance_name.to_s.pluralize}")
    end

    def resource_instance= instance
      instance_variable_set("@#{instance_name}", instance)
    end

    def collection_instance= instance
      instance_variable_set("@#{instance_name.to_s.pluralize}", instance)
    end


    if options[:singleton]

      define_method :edit do
      end

      define_method :update do
        @member = @parent || klass.new

        if @member.update_attributes(data_params)
          flash[:success] = i18n_message(:update_success_without_title, klass.model_name.i18n_key)
          redirect_to action: :show
        else
          render :edit
        end
      end

    else # singletion
      
      define_method :index do
      end

      define_method :show do
      end

      unless options[:readonly]
        define_method :new do
        end

        define_method :create do
          if resource_instance.save
            index_path = { action: :index }
            flash[:success] = i18n_message(:create_success, klass.model_name.i18n_key)
            redirect_to index_path
          else
            render :new
          end
        end

        define_method :edit do
        end

        define_method :update do
          if resource_instance.update_attributes params[namespaced_name]
            flash[:success] = i18n_message(:update_success, klass.model_name.i18n_key)
            redirect_to action: :index
          else
            render :edit
          end
        end

        define_method :destroy do
          resource_instance.destroy

          flash[:success] = i18n_message(:destroy_success, klass.model_name.i18n_key)
          redirect_to action: :index
        end
      end

    end # singletion

    define_method :i18n_message do |message_type, model|
      resource = resource_instance
      i18n_options = { model: I18n.t(model, scope: 'activerecord.models') }
      title = options[:title]||:title
      i18n_options[:title] = resource.send(title) if resource.respond_to? title
      I18n.t(message_type, i18n_options)
    end

  end

end
