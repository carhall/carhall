class Weixin::Tips::AdTemplatesController < Weixin::ApplicationController
  set_resource_class Business::AdTemplate, shallow: true

end