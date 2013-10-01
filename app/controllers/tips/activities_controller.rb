class Tips::ActivitiesController < Tips::ApplicationController
  set_resource_class Tips::Activity, expiredable: true

  def data_params
    params.require(:tips_activity).permit(:title, :expire_at, :description, :image)
  end
  
end
