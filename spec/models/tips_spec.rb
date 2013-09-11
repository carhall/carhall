require 'spec_helper'

describe "Tips" do
  let(:dealer) { create :dealer }

  describe Mending do
    subject { create :mending, dealer: dealer }
    include_examples "valid record"
  end

  describe Cleaning do
    subject { create :cleaning, dealer: dealer }
    include_examples "valid record"
  end

  describe Activity do
    subject { create :activity, dealer: dealer }
    include_examples "valid record"
  end

  describe BulkPurchasing do
    subject { create :bulk_purchasing, dealer: dealer }
    include_examples "valid record"
  end

  shared_examples "orders#use" do
    it do 
      subject.use 
      subject.should be_valid
    end
    it do
      subject.cancel!
      subject.use 
      subject.should_not be_valid
    end
    it do
      count = subject.detail.count
      subject.use(count)
      subject.should be_finished
    end
    it do
      count = subject.detail.count
      subject.use(count + 1)
      subject.should_not be_valid
    end
    it do
      expect { subject.use(-1) }.to raise_error
    end
  end

  shared_examples "orders#finish" do
    it do 
      subject.finish 
      subject.should be_valid
    end
    it do 
      subject.cancel!
      subject.finish 
      subject.should_not be_valid
    end
  end

  shared_examples "orders#cancel" do
    it do 
      subject.cancel 
      subject.should be_valid
    end
  end

  describe MendingOrder do
    subject { create :mending_order, source: create(:mending, dealer: dealer)}
    include_examples "valid record"
    include_examples "orders#finish"
    include_examples "orders#cancel"
  end

  describe CleaningOrder do
    subject { create :cleaning_order, source: create(:cleaning, dealer: dealer)}
    include_examples "valid record"
    include_examples "orders#use"
    include_examples "orders#finish"
    include_examples "orders#cancel"
  end

  describe MendingOrder do
    subject { create :bulk_purchasing_order, source: create(:bulk_purchasing, dealer: dealer)}
    include_examples "valid record"
    include_examples "orders#finish"
    include_examples "orders#cancel"
  end

  describe Review do
    subject { create :review }
    include_examples "valid record"
  end
end