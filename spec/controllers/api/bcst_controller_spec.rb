require 'spec_helper'

describe "Bcst" do
  include_context "shared context"

  let(:provider) { create :provider }
  let(:append_attrs_when_build) {{ provider: provider }}
  let(:append_args) {{ provider_id: provider.id }}
  
  shared_examples "bcst#resources" do  
    include_examples "resources#index"

    include_examples "resources#show"
    include_examples "resources#detail"
  end

  describe Api::Bcst::HostsController do
    let(:resource) { :host }
    include_examples "bcst#resources"    
  end

  describe Api::Bcst::ProgrammesController do
    let(:resource) { :programme }
    include_examples "bcst#resources"    
  end

  describe Api::Bcst::ProgrammeListsController do
    let(:resource) { :programme_list }
    include_examples "resources#show"
  end

  describe Api::Bcst::ExposuresController do
    let(:resource) { :exposure }
    let(:append_attrs_when_build) {{ source: provider, user: user }}
    let(:append_args) {{ provider_id: provider.id }}
    include_examples "resources#index"
    include_examples "resources#show"
    include_examples "resources#create"
    include_examples "resources#destroy"

    describe "when exposure belongs to other" do
      let(:append_attrs_when_build) {{ source: provider, user: other }}
      include_examples "resources#destroy failed"
    end
  end

  describe Api::Bcst::TrafficReportsController do
    let(:resource) { :traffic_report }
    let(:append_attrs_when_build) {{ provider: provider, user: user }}
    let(:append_args) {{ provider_id: provider.id }}
    include_examples "resources#index"
    include_examples "resources#show"
    include_examples "resources#create"
    include_examples "resources#destroy"

    describe "when traffic_report belongs to other" do
      let(:append_attrs_when_build) {{ provider: provider, user: other }}
      include_examples "resources#destroy failed"
    end
  end

  describe Api::CommentsController do
    let(:resource) { :programme_comment }
    let(:programme) { create :programme, provider: provider }
    let(:append_attrs_when_build) {{ source: programme, user: user }}
    let(:append_args) {{ provider_id: provider.id, programme_id: programme.id }}
    include_examples "resources#index"
    include_examples "resources#show"
    include_examples "resources#create"
    include_examples "resources#destroy"
    
    describe "when programme_comment belongs to other" do
      let(:append_attrs_when_build) {{ source: programme, user: other }}
      include_examples "resources#destroy failed"
    end
  end
end