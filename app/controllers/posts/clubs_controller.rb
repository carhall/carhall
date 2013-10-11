class Posts::ClubsController < Posts::ApplicationController
  set_resource_class Posts::Club

  def relieve_president
    @club.relieve_president!

    flash[:success] = i18n_message(:relieve_success)
    redirect_to :back
  end

  def relieve_mechanic
    @club.relieve_mechanic! params[:mechanic_id]

    flash[:success] = i18n_message(:relieve_success)
    redirect_to :back
  end

end