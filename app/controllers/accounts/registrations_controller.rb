class Accounts::RegistrationsController < Devise::RegistrationsController
  def build_resource hash=nil
    self.resource = if params[resource_name] and params[resource_name][:type].present?
      params[resource_name][:type].constantize.new hash
    else
      Accounts::Account.new
    end
  end

  def account_params
    return @account_params if @account_params
    @account_params = params.require(resource_name).permit!
    permit = [:mobile, :current_password, :password, :password_confirmation, 
      :username, :description, :avatar, :area_id, :weixin_app_id, :weixin_app_secret]
    case @account_params[:type]
    when "Accounts::Provider"
      permit << :type
      permit << {detail_attributes: [:id, :company, :phone, {template_ids: []}]}
    when "Accounts::Dealer"
      permit << :type
      permit << {detail_attributes: [:id, :dealer_type_id, :specific_service_id, 
        :business_scope_ids, :company, :address, :phone, :open_during, 
        :authentication_image,
        {template_ids: []}, {business_scope_ids: []}]}
    when "Accounts::Distributor"
      permit << :type
      permit << {detail_attributes: [:id, :distributor_type_id, 
        :business_scope_ids, :company, :address, :phone,
        :authentication_image, {product_ids: []}, {brand_ids: []},
        {business_scope_ids: []}]}
    else
    end
    @account_params = @account_params.permit(permit)
  end

  # POST /resource
  def create
    build_resource(account_params)

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

    if account_params[:current_password].present?
      result = resource.update_with_password(account_params)
    else
      account_params.delete :current_password
      result = resource.update_without_password(account_params)
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

protected

  def after_update_path_for resource
    if params[:redirect_to]
      params[:redirect_to]
    else
      setting_path
    end
  end

  def after_inactive_sign_up_path_for resource
    return { action: :edit, controller: :'accounts/confirmations' } unless resource.confirmed?
    dashboard_path
  end

  def after_resending_confirmation_instructions_path_for resource
    new_user_confirmation_path
  end

end 