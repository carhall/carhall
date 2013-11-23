class DistributorsController < ApplicationController
  def index
    @distributors = ::Accounts::Distributor.accepted

    @distributors = set_filter_id @distributors, :business_scope
    @distributors = set_filter_id @distributors, :main_area
    @distributors = set_filter_id @distributors, :product
  end

  def show
    @distributor = ::Accounts::Distributor.find(params[:id])
  end
  
  def make_friend
    @distributor = ::Accounts::Distributor.find(params[:id])
    @current_user.make_friend_with! @distributor
    redirect_to :back
  end
  
  def break
    @distributor = ::Accounts::Distributor.find(params[:id])
    @current_user.break_with! @distributor
    redirect_to :back
  end

  def manual_images
    @distributor = ::Accounts::Distributor.find(params[:id])
    @manual_images = @distributor.manual_images
  end
  
end
