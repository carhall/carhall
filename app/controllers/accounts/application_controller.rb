class Accounts::ApplicationController < ApplicationController

  def self.set_resource_class klass, options = {}
    super klass, options.merge(title: :username)

    define_method :account_params do
      params[namespaced_name]
    end

    if options[:weixin]
      define_method :update_weixin do
        klass.update_weixin
        redirect_to :back
      end
    end

    if options[:accept]
      define_method :accept do
        account = resource_instance
        account.accept!
        flash
        redirect_to :back
      end
    end

    if options[:display]
      define_method :expose do
        account = resource_instance
        account.expose!
        flash[:success] = i18n_message(:show_success)
        redirect_to :back
      end
      define_method :hide do
        account = resource_instance
        account.hide!
        flash[:success] = i18n_message(:hide_success)
        redirect_to :back
      end

      define_method :stick do
        account = resource_instance
        account.stick!
        flash[:success] = i18n_message(:stick_success)
        redirect_to :back
      end
      define_method :unstick do
        account = resource_instance
        account.unstick!
        flash[:success] = i18n_message(:unstick_success)
        redirect_to :back
      end

    end

    if options[:rank]
      define_method :rank_up do
        account = resource_instance
        account.rank_up!
        flash[:success] = i18n_message(:rank_up_success)
        redirect_to :back
      end
      define_method :rank_down do
        account = resource_instance
        account.rank_down!
        flash[:success] = i18n_message(:rank_down_success)
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
        flash[:success] = i18n_message(:update_success)
        redirect_to action: :index
      else
        render :edit
      end

    end
  end

end