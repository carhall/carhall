class Users::RegistrationsController < Devise::RegistrationsController
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
end 