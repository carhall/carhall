# For Base Resources
shared_examples_for "resources#collection base" do
  it "has a 200 status code, and return a array" do
    get collection_name, reset_args
    response.status.should eq(200), error_messages

    response_body['data'].should be_kind_of Array
    response_body['data'].should have_at_least(3).items
  end
  it "when per_page=1, pagerizes has a 200 status code, and return a array of size 1" do
    get collection_name, { page: 1, per_page: 1 }.merge(reset_args)
    response.status.should eq(200)

    response_body['data'].should have(1).items
  end
end

shared_examples_for "resources#collection" do
  before { 3.times { create resource_name, attach_attrs }}
  include_examples "resources#collection base"
end

shared_examples_for "resources#member" do
  it "has a 200 status code, and return a object" do
    get member_name, reset_args
    response.status.should eq(200), error_messages

    response_body['data'].should be_kind_of Hash
  end
end

shared_examples_for "resources#post" do
  it "has a 201 status code" do
    post post_name, reset_args
    response.status.should eq(201), error_messages
  end
end

shared_examples_for "resources#put" do
  it "has a 202 status code" do
    put put_name, reset_args
    response.status.should eq(202), error_messages
  end
end

shared_examples_for "resources#delete" do
  it "has a 202 status code" do
    delete delete_name, reset_args
    response.status.should eq(202), error_messages
  end
end

# For Resources
shared_examples_for "resources#index base" do
  describe "GET index" do
    let(:collection_name) { :index }
    include_examples "resources#collection base"
  end
end

shared_examples_for "resources#index" do
  describe "GET index" do
    let(:collection_name) { :index }
    include_examples "resources#collection"
  end
end

shared_examples_for "resources#show" do
  describe "GET show" do
    let(:default_args) {{ id: id }}
    let(:member_name) { :show }
    include_examples "resources#member"
  end
end

shared_examples_for "resources#detail" do
  describe "GET detail" do
    let(:default_args) {{ id: id }}
    let(:member_name) { :detail }
    include_examples "resources#member"
  end
end

shared_examples_for "resources#create" do
  describe "POST create" do
    let(:default_args) {{ data: attributes }}
    let(:post_name) { :create }
    include_examples "resources#post"
  end
end

shared_examples_for "resources#destroy" do
  describe "DELETE destroy" do
    let(:default_args) {{ id: id }}
    let(:delete_name) { :destroy }
    include_examples "resources#delete"
  end
end

# For Resource
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
    let(:default_args) {{ data: attributes }}
    let(:put_name) { :update }
    include_examples "resources#put"
  end
end