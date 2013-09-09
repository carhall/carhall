module FilterHelper
  protected

  extend ActiveSupport::Concern

  def current_ability
    @current_ability ||= Ability.new(current_base_user)
  end

  def ensure_base_user_type *user_types
    raise CanCan::AccessDenied unless user_types.include? @user_type
  end

  module ClassMethods
    def ensure_base_user_type *user_types
      prepend_before_filter do
        set_user_type
        raise CanCan::AccessDenied unless user_types.include? @user_type
      end
    end

    def ensure_base_user_accepted
      prepend_before_filter do
        set_user_type
        raise CanCan::AccessDenied unless @user.accepted?
      end
    end
  end

  def set_user
    @user ||= if user_id = params[:user_id]
      BaseUser.find(user_id)
    else
      current_base_user
    end
  end

  def set_current_user
    @user ||= current_base_user
  end

  def set_area_id_and_brand_id
    if filter = params[:filter]
      @area_id = filter[:area_id]
      @brand_id = filter[:brand_id]
    elsif (@user ||= set_current_user).user_type == :user
      detail = @user.detail
      @area_id = detail.area_id
      @brand_id = detail.brand_id
    end
  end

  def set_user_type
    @user ||= current_base_user
    @user_type ||= (@user || BaseUser.new).user_type
  end
  
  def set_dealer
    @dealer = Dealer.find(@user.id)
  end
end
