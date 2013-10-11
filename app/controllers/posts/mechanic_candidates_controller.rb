class Posts::MechanicCandidatesController < Posts::ApplicationController
  set_resource_class Posts::MechanicCandidate

  def appoint
    candidate = resource_instance
    club = candidate.source
    club.appoint_mechanic candidate.user
    club.save

    flash[:success] = i18n_message(:appoint_success)
    redirect_to :back
  end

  def i18n_title
    resource_instance.user.username
  end

end