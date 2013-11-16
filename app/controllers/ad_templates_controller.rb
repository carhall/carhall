class AdTemplatesController < ApplicationController
  def index
    @ad_templates = ::Business::AdTemplate.all

    @ad_templates = set_filter_id @ad_templates, :product_type
    @ad_templates = set_filter_id @ad_templates, :product
  end

  def show
    @ad_template = ::Business::AdTemplate.find(params[:id])
  end

  def buy
    @ad_template = ::Business::AdTemplate.find(params[:id])
    if @ad_template.buy @current_user
      send_file @ad_template.file.path
    else
      flash[:error] = t("not_enough_balance")
      redirect_to :back
    end
  end
  
end
