class Tips::AdTemplatesController < Tips::ApplicationController

  def account_params
    params.require(:accounts_distributor).permit(ad_template_ids: [])
  end

  def update
    @current_user.update_without_password(account_params)
    if @current_user.save
      flash[:success] = I18n.t(:update_success_without_title, model: Business::AdTemplate.model_name.human)
      redirect_to tips_root_path
    else
      render :edit
    end
  end

end
