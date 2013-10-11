class Posts::PresidentCandidatesController < Posts::ApplicationController
  set_resource_class Posts::PresidentCandidate

  def appoint
    candidate = resource_instance
    club = candidate.source
    club.appoint_president candidate.user
    club.save

    flash[:success] = i18n_message(:appoint_success)
    redirect_to :back
  end

  def i18n_title
    resource_instance.user.username
  end

end