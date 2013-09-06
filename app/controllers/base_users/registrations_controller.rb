class BaseUsers::RegistrationsController < Devise::RegistrationsController
  def resource_class
    if @resource_class
      @resource_class
    elsif params[:base_user].nil?
      @resource_class = Provider
    else
      user_type = params[:base_user][:user_type_id]
      @resource_class = [Provider, Dealer][user_type.to_i]
    end
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_mobile = resource.unconfirmed_mobile if resource.respond_to?(:unconfirmed_mobile)

    if account_update_params[:current_password].present?
      result = resource.update_with_password(account_update_params)
    else
      account_update_params.delete :current_password
      result = resource.update_without_password(account_update_params)
    end

    if result
      if is_navigational_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_mobile) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def after_update_path_for resource
    setting_path
  end

  def after_inactive_sign_up_path_for resource
    return { action: :edit, controller: :'base_users/confirmations' } unless resource.confirmed?
    dashboard_path
  end

  def after_resending_confirmation_instructions_path_for resource
    new_base_user_confirmation_path
  end

end 