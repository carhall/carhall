class Accounts::CandidatesController < Accounts::ApplicationController
  authorize_resource class: Posts::Club

  def president
    if params[:id]
      @club = ::Posts::Club.find(params[:id])
      render 'president'
    else
      @clubs = ::Posts::Club.all
      render 'presidents'
    end
  end

  def mechanic
    if params[:id]
      @club = ::Posts::Club.find(params[:id])
      render 'mechanic'
    else
      @clubs = ::Posts::Club.all
      render 'mechanics'
    end
  end

end