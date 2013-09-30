class Tips::ActivitiesController < Tips::ApplicationController
  set_resource_class Activity, expiredable: true

  def data_params
    params.require(:activity).permit(:title, :expire_at, :description, :image)
  end
  
end
