require 'spec_helper'

describe Api::Tips::MendingsController do
  include_context "for devise"

  let(:resource_name) { :mending }

  include_examples "resources#index"
  include_examples "resources#show"
end

# describe Api::Tips::ActivitiesController do
#   let(:resource_name) { :activity }

#   include_examples "resource#index"
#   include_examples "resource#show"
# end
