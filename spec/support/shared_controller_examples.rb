# For resources
shared_examples_for "resources#collection" do
  before { 3.times { create resource_name rescue nil }}
  
  it "has a 200 status code" do
    get collection_name, attach_args
    response.status.should eq(200), error_messages
  end
  it "return a array" do
    get collection_name, attach_args
    response_body['data'].should be_kind_of Array
    response_body['data'].should have_at_least(3).items
  end
  it "pagerizes" do
    get collection_name, { page: 1, per_page: 1 }.merge(attach_args)
    response.status.should eq(200)
  end
  it "when per_page=1, return a array of size 1" do
    get collection_name, { page: 1, per_page: 1 }.merge(attach_args)
    response_body['data'].should have(1).items
  end
end

shared_examples_for "resources#index" do
  describe "GET index" do
    let(:collection_name) { :index }
    include_examples "resources#collection"
  end
end

shared_examples_for "resources#member" do
  it "has a 200 status code" do
    get member_name, { id: id }.merge(attach_args)
    response.status.should eq(200), error_messages
  end
  it "return a object" do
    get member_name, { id: id }.merge(attach_args)
    response_body['data'].should be_kind_of Hash
  end
end

shared_examples_for "resources#show" do
  describe "GET show" do
    let(:member_name) { :show }
    include_examples "resources#member"
  end
end

shared_examples_for "resources#detail" do
  describe "GET detail" do
    let(:member_name) { :detail }
    include_examples "resources#member"
  end
end

shared_examples_for "resources#create" do
  describe "POST create" do
    it "has a 201 status code" do
      post :create, reset_args || { data: attributes }.merge(attach_args)
      response.status.should eq(201), error_messages
    end
  end
end

shared_examples_for "resources#delete" do
  describe "DELETE destroy" do
    it "has a 202 status code" do
      delete :destroy, { id: id }.merge(attach_args)
      response.status.should eq(202), error_messages
    end
  end
end

# For resources
shared_examples_for "resource#show" do
  describe "GET show" do
    let(:member_name) { :show }
    include_examples "resources#member"
  end
end

shared_examples_for "resource#detail" do
  describe "GET detail" do
    let(:member_name) { :detail }
    include_examples "resources#member"
  end
end

shared_examples_for "resource#update" do
  describe "PUT update" do
    it "has a 202 status code" do
      put :update, reset_args || { data: attributes }.merge(attach_args)
      response.status.should eq(202), error_messages
    end
  end
end