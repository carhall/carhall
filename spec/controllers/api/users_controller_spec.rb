require 'spec_helper'

describe "Users" do
  include_context "shared context"

  describe Api::UsersController do
    let(:resource_name) { :user }

    include_examples "resources#show"
    include_examples "resources#detail"
    include_examples "resources#create"
  end

  describe Api::AccountsController do
    let(:resource_name) { :user }

    include_examples "resources#show"
    include_examples "resources#detail"

    describe "POST login" do
      it "has a 201 status code" do
        post :login, data: { mobile: user.mobile, password: user.password }
        expect(response.status).to eq(201), error_messages
      end
    end
  end

  describe Api::CurrentUsersController do
    let(:resource_name) { :user }

    include_examples "resource#show"
    include_examples "resource#detail"
    include_examples "resource#update"

    describe "PUT password" do
      describe "without current_password" do
        it "has a 422 status code" do
          put :password, data: attributes
          expect(response.status).to eq(422), error_messages
        end
      end
      describe "with current_password" do
        it "has a 202 status code" do
          put :password, data: attributes.merge(current_password: "password")
          expect(response.status).to eq(202), error_messages
        end
      end
    end
  end

  describe Api::DealersController do
    let(:resource_name) { :dealer }

    include_examples "resources#index"
    include_examples "resources#show"
    include_examples "resources#detail"

    describe "GET nearby" do
      let(:default_args) {{ lat: 40, lng: 116.3 }}
      let(:collection_name) { :nearby }
      include_examples "resources#collection"
    end

    describe "GET favorite" do
      let(:collection_name) { :favorite }
      include_examples "resources#collection"
    end
    
    describe "GET hot" do
      let(:collection_name) { :hot }
      include_examples "resources#collection"
    end

    context "with dealer_type_id" do
      let(:attach_attrs) {{ detail: attributes_for(:dealer)[:detail].merge(dealer_type_id: 1) }}
      let(:filter_args) {{ filter: { dealer_type_id: 1 }}}
      let(:empty_filter_args) {{ filter: { dealer_type_id: 2 }}}
      include_examples "resources#index filter"
    end

    context "with bussiness_scope_id" do
      let(:attach_attrs) {{ detail: attributes_for(:dealer)[:detail].merge(business_scope_ids: [1]) }}
      let(:filter_args) {{ filter: { business_scope_id: 1 }}}
      let(:empty_filter_args) {{ filter: { business_scope_id: 2 }}}
      include_examples "resources#index filter"
    end
  end

  describe Api::ProvidersController do
    let(:resource_name) { :provider }

    include_examples "resources#index"
    include_examples "resources#show"
    include_examples "resources#detail"
  end

  describe Api::FriendsController do
    let(:resource_name) { :user }

    before { 3.times { user.make_friend_with(create(:user)).save }}

    include_examples "resources#index base"
    context "with user_id" do
      let(:attach_args) {{ user_id: user.id }}
      include_examples "resources#index base"
    end
    context do
      let(:reset_args) {{ id: id }}
      include_examples "resources#create"
    end
    include_examples "resources#destroy"
  end

  describe Api::BlacklistsController do
    let(:resource_name) { :user }

    before { 3.times { user.add_to_blacklist(create(:user)).save }}

    include_examples "resources#index base"
    context do
      let(:reset_args) {{ id: id }}
      include_examples "resources#create"
    end
    include_examples "resources#destroy"
  end
end

describe Api::ConstantsController do
  include_context "shared context"

  it "has a 200 status code, and return a array" do
    get :index, {}
    response.status.should eq(200), error_messages

    response_body['data'].should (be_kind_of Hash), error_messages
  end

  it "has a 200 status code" do
    get :show, {id: 'sexes'}
    response.status.should eq(200), error_messages

    response_body['data'].should (be_kind_of Array), error_messages
  end
end