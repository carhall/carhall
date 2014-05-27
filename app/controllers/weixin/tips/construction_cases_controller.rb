class Weixin::Tips::ConstructionCasesController < Weixin::ApplicationController
  set_resource_class ::Tips::ConstructionCase, shallow: true

end