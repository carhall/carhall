class Api::Accounts::UsersController < Api::Accounts::ApplicationController
  skip_before_filter :authenticate_account!, only: [:create]

  set_resource_class ::Accounts::User, detail: true

  # POST /api/users
  # POST /api/users.json
  def create
    @user = ::Accounts::User.new data_params
    @user.reset_authentication_token

    render_create @user, :with_token
  end

  private
    # Using a private method to encapsulate the permissible parameters is just a good pattern
    # since you'll be able to reuse the same permit list between create and update. Also, you
    # can specialize this method with per-user checking of permissible attributes.
    def data_params
      params.require(:data).permit(:username, :mobile, :description, :avatar, 
        :password, :password_confirmation, 
        detail: [:id, :sex_id, :sex, :area_id, :area, :brand_id, :brand, 
          :series, :plate_num, :car_image]
      )
    end
end
