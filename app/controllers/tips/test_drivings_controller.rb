class Tips::TestDrivingsController < Tips::ApplicationController
  set_resource_class Tips::TestDriving, orders: true, instance_name: :test_driving

  def tips_test_driving_params
    test_driving_params = params.require(:tips_test_driving).permit(:title, 
      :brand_id, :series, :description, :price, :image)
    test_driving_params[:params] = params.require(:tips_test_driving).require(:params).permit!
    test_driving_params
  end

  def namespaced_name
    :tips_test_driving
  end

  def instance_name
    :test_driving
  end

end
