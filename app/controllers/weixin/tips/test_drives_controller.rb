class Weixin::Tips::TestDrivesController < Weixin::ApplicationController
  set_resource_class ::Tips::TestDrive, instance_name: :test_drive

  def instance_name
    :test_drive
  end

end