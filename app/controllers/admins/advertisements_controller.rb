class Admins::AdvertisementsController < ApplicationController
  before_filter :find_model

  
private

  def find_model
    @model = Advertisements.find(params[:id]) if params[:id]
  end
end