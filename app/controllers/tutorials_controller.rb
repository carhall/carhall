class TutorialsController < ApplicationController
  before_filter :set_adverts

  def set_adverts
    @adverts = Business::Advert.tutorial
  end

  def index
    @tutorials = ::Business::Tutorial.all

    @tutorials = set_filter_id @tutorials, :product_type
    @tutorials = set_filter_id @tutorials, :product
  end

  def show
    @tutorial = ::Business::Tutorial.find(params[:id])
  end
  
end
