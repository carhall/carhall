module FilterHelper
  protected

  def current_ability
    @current_ability ||= Ability.new(current_account)
  end

  def filter_parent key
    if params[:filter]
      if params[:filter][:"#{key}_id"]
        @parent = @parent.send(:"with_#{key}", params[:filter][:"#{key}_id"].to_i)
      end
      if params[:filter][:"#{key}"]
        @parent = @parent.send(:"with_#{key}", params[:filter][:"#{key}"])
      end
    end
  end

  def search_parent
    if params[:query]
      @parent = @parent.with_query(params[:query])
    end
  end

  def set_user
    @user = if user_id = params[:user_id]
      Accounts::User.find(user_id)
    else
      current_account
    end
  end

  def set_current_user
    @user ||= @current_user = current_account
  end

  def set_area_id_and_brand_id
    if filter = params[:filter]
      @area_id = filter[:area_id]
      @brand_id = filter[:brand_id]
    elsif (@user ||= set_current_user).user_type == :user
      @area_id = @user.area_id
      @brand_id = @user.brand_id
    end
  end

  def set_user_type
    @user_type = (current_account || Accounts::User.new).user_type
  end
  
  def set_distributor
    @distributor = current_account if current_account.user_type == :distributor
  end

  def set_dealer
    @dealer = current_account if current_account.user_type == :dealer
  end

  def set_provider
    @provider = current_account if current_account.user_type == :provider
  end

  def set_admin
    @admin = current_account if current_account.user_type == :admin
  end
end
