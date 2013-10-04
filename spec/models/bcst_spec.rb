require 'spec_helper'

describe "Bcst" do
  let(:provider) { create :provider }

  describe Bcst::Programme do
    subject { create :programme, provider: provider }
    include_examples "valid record"
  end

  describe Bcst::Host do
    subject { create :host, provider: provider }
    include_examples "valid record"
  end

  describe Bcst::ProgrammeList do
    subject { create :programme_list, provider: provider }
    include_examples "valid record"
  end

  describe Bcst::Comment do
    subject { create :programme_comment }
    include_examples "valid record"
  end

  describe Bcst::Exposure do
    subject { create :exposure, source: provider }
    include_examples "valid record"
  end
  
  describe Bcst::TrafficReport do
    subject { create :traffic_report, source: provider }
    include_examples "valid record"
  end
end
