class Accounts::ApplicationController < ApplicationController

  def self.set_resource_class klass, options = {}
    super klass, options.merge(title: :username)

    define_method :account_params do
      params[namespaced_name]
    end

    if options[:accept]
      define_method :accept do
        account = resource_instance
        account.accept!
        redirect_to :back
      end
    end

    if options[:display]
      define_method :expose do
        account = resource_instance
        account.expose!
        redirect_to :back
      end
      define_method :hide do
        account = resource_instance
        account.hide!
        redirect_to :back
      end

      define_method :stick do
        account = resource_instance
        account.stick!
        redirect_to :back
      end
      define_method :unstick do
        account = resource_instance
        account.unstick!
        redirect_to :back
      end

    end

    define_method :update do
      account = resource_instance
      prev_unconfirmed_mobile = account.unconfirmed_mobile if account.respond_to?(:unconfirmed_mobile)

      if account_params[:current_password].present?
        result = account.update_with_password(account_params)
      else
        account_params.delete :current_password
        result = account.update_without_password(account_params)
      end
      
      if result
        flash[:success] = i18n_message(:update_success, klass.name.underscore)
        redirect_to action: :index
      else
        render :edit
      end

    end
  end

end