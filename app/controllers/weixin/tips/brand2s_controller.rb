class Weixin::Tips::Brand2sController < Weixin::ApplicationController
  set_resource_class ::Category::Brand2, no_authorize: true, through: nil
  before_filter :load_area_and_brand

private

  def load_area_and_brand
    @area_id = params[:area_id] || 1
    @brand_id = params[:brand_id] || 1
  end

end