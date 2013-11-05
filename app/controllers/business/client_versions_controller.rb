class Business::ClientVersionsController < ApplicationController
  set_resource_class Business::ClientVersion

  def business_client_version_params
    params.require(:business_client_version).permit(:file, :client_type_id, :version)
  end

end