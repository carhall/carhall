class Accounts::ApplicationController < ApplicationController

  def self.set_resource_class klass, options = {}
    super klass, options

    define_method :account_params do
      params[namespaced_name]
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

  def i18n_message message_type, klass
    resource = resource_instance
    options = { model: I18n.t(klass.model_name.i18n_key, scope: 'activerecord.models') }
    options[:title] = resource.username
    I18n.t(message_type, options)
  end

end