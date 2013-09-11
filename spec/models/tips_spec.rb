require 'spec_helper'

describe Mending do
  subject { create :mending }
  it_behaves_like "valid record"
end

describe Cleaning do
  subject { create :cleaning }
  it_behaves_like "valid record"
end

describe Activity do
  subject { create :activity }
  it_behaves_like "valid record"
end

describe BulkPurchasing do
  subject { create :bulk_purchasing }
  it_behaves_like "valid record"
end
