# For Base Resources
shared_context "create many" do
  before { 3.times { create resource, append_attrs_when_build }}
end

shared_context "create one" do
  before { @id = create(resource, append_attrs_when_build).id }
end

shared_examples_for "resources#collection many" do |action, code=200|
  it "has a #{code} status code, and return a array" do
    get action, args
    response.status.should eq(code), error_messages

    response_body['data'].should be_kind_of Array
    response_body['data'].should have_at_least(3).items, error_messages
  end
end
shared_examples_for "resources#collection empty" do |action, code=200|
  it "has a #{code} status code, and return a empty array" do
    get action, args
    response.status.should eq(code), error_messages

    response_body['data'].should be_kind_of Array
    response_body['data'].should have_at_least(0).items, error_messages
  end
end
shared_examples_for "resources#collection pagerizes" do |action, code=200|
  it "when per_page=1, pagerizes has a #{code} status code, and return a array of size 1" do
    get action, { page: 1, per_page: 1 }.merge(args)
    response.status.should eq(code)

    response_body['data'].should have(1).items, error_messages
  end
end

shared_examples_for "resources#collection" do |action, code=200|
  include_examples "resources#collection many", action, code
  include_examples "resources#collection pagerizes", action, code
end

shared_examples_for "resources#collection filtered" do |action, code=200|
  include_examples "resources#collection many", action, code
  it "has a #{code} status code, and return a empty array" do
    get action, other_args
    response.status.should eq(code), error_messages

    response_body['data'].should be_kind_of Array
    response_body['data'].should have_at_least(0).items, error_messages
  end
end

shared_examples_for "resources#member" do |action, code=200|
  it "has a #{code} status code, and return a object" do
    get action, args
    response.status.should eq(code), error_messages

    response_body['data'].should be_kind_of Hash
  end
end

shared_examples_for "resources#post" do |action, code=201|
  it "has a #{code} status code" do
    post action, args
    response.status.should eq(code), error_messages
  end
end

shared_examples_for "resources#put" do |action, code=202|
  it "has a #{code} status code" do
    put action, args
    response.status.should eq(code), error_messages
  end
end

shared_examples_for "resources#delete" do |action, code=202|
  it "has a #{code} status code" do
    delete action, args
    response.status.should eq(code), error_messages
  end
end



# For Resources
shared_examples_for "resources#list" do |action, args={}|
  describe "GET #{action}" do
    include_context "create many"
    let(:args) { args }
    include_examples "resources#collection", action
  end
end

shared_examples_for "resources#index" do
  describe "GET index" do
    include_context "create many"
    include_examples "resources#collection", :index
  end
end

shared_examples_for "resources#index empty" do
  describe "GET index" do
    include_context "create many"
    include_examples "resources#collection empty", :index
  end
end

shared_examples_for "resources#index filtered" do
  describe "GET index with filters" do
    include_context "create many"
    include_examples "resources#collection filtered", :index
  end
end

shared_examples_for "resources#get" do |action, args={}|
  describe "GET #{action}" do
    include_context "create one"
    let(:args) {{ id: id }.merge(append_args).merge(args) }
    include_examples "resources#member", action
  end
end

shared_examples_for "resources#show" do
  describe "GET show" do
    include_context "create one"
    let(:args) {{ id: id }.merge(append_args) }
    include_examples "resources#member", :show
  end
end

shared_examples_for "resources#detail" do
  describe "GET detail" do
    include_context "create one"
    let(:args) {{ id: id }.merge(append_args) }
    include_examples "resources#member", :detail
  end
end

shared_examples_for "resources#create" do
  describe "POST create" do
    let(:args) {{ data: data }.merge(append_args) }
    include_examples "resources#post", :create
  end
end

shared_examples_for "resources#update" do
  describe "PUT update" do
    include_context "create one"
    let(:args) {{ id: id, data: data }.merge(append_args) }
    include_examples "resources#put", :update
  end
end

shared_examples_for "resources#destroy" do
  describe "DELETE destroy" do
    include_context "create one"
    let(:args) {{ id: id }.merge(append_args) }
    include_examples "resources#delete", :destroy
  end
end

shared_examples_for "resources#create failed" do
  describe "POST create failed" do
    let(:args) {{ data: data }.merge(append_args) }
    include_examples "resources#post", :create, 403
  end
end

shared_examples_for "resources#update failed" do
  describe "PUT update failed" do
    include_context "create one"
    let(:args) {{ id: id, data: data }.merge(append_args) }
    include_examples "resources#put", :update, 403
  end
end

shared_examples_for "resources#destroy failed" do
  describe "DELETE destroy failed" do
    include_context "create one"
    let(:args) {{ id: id }.merge(append_args) }
    include_examples "resources#delete", :destroy, 403
  end
end



# For Resource
shared_examples_for "resource#show" do
  describe "GET show" do
    include_examples "resources#member", :show
  end
end

shared_examples_for "resource#detail" do
  describe "GET detail" do
    include_examples "resources#member", :detail
  end
end

shared_examples_for "resource#update" do
  describe "PUT update" do
    let(:args) {{ data: data }.merge(append_args) }
    include_examples "resources#put", :update
  end
end