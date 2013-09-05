module Api
  module FilterHelper
    protected

    def set_user
      if user_id = params[:user_id]
        @user = BaseUser.find(user_id)
      else
        @user = current_base_user
      end
    end

    def set_current_user
      @user = current_base_user
    end

    def set_area_id_and_brand_id
      if filter = params[:filter]
        @area_id = filter[:area_id]
        @brand_id = filter[:brand_id]
      elsif @user.user_type == :user
        detail = @user.detail
        @area_id = detail.area_id
        @brand_id = detail.brand_id
      end
    end

    def set_user_type
      @user ||= current_base_user
      @user_type ||= (@user || BaseUser.new).user_type
    end
  end
end