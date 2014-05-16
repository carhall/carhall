class Tips::TestDrivesController < Tips::ApplicationController
  set_resource_class Tips::TestDrive, orders: true, instance_name: :test_drive

  def tips_test_drive_params
    test_drive_params = params.require(:tips_test_drive).permit(:title, 
      :brand_id, :series, :price, :image)
    test_drive_params[:params] = params.require(:tips_test_drive).require(:params).permit!
    test_drive_params
  end

  def namespaced_name
    :tips_test_drive
  end

  def instance_name
    :test_drive
  end

end
