require 'spec_helper'

describe "Users" do
  include_context "shared context"

  describe Api::Accounts::AccountsController do
    let(:resource) { :user }

    include_examples "resources#show"
    include_examples "resources#detail"

    describe "POST login" do
      it "has a 201 status code" do
        post :login, data: { mobile: user.mobile, password: user.password }
        expect(response.status).to eq(201), error_messages
      end
    end
  end

  describe Api::Accounts::UsersController do
    let(:resource) { :user }

    include_examples "resources#show"
    include_examples "resources#detail"
    include_examples "resources#create"
  end

  describe Api::Accounts::CurrentUsersController do
    let(:resource) { :user }

    include_examples "resource#show"
    include_examples "resource#detail"
    include_examples "resource#update"

    describe "PUT password" do
      describe "without current_password" do
        it "has a 422 status code" do
          put :password, data: data
          expect(response.status).to eq(422), error_messages
        end
      end

      describe "with current_password" do
        it "has a 202 status code" do
          put :password, data: data.merge(current_password: "password")
          expect(response.status).to eq(202), error_messages
        end
      end
    end
  end

  describe Api::Accounts::DealersController do
    let(:resource) { :dealer }

    include_examples "resources#index"
    include_examples "resources#show"
    include_examples "resources#detail"

    include_examples "resources#list", :nearby, lat: 40, lng: 116.3
    include_examples "resources#list", :favorite
    include_examples "resources#list", :hot

    context "with area_id" do
      let(:append_attrs_when_build) {{ area_id: 1 }}
      let(:args) {{ filter: { area_id: 1 }}}
      let(:other_args) {{ filter: { area_id: 2 }}}
      include_examples "resources#index filtered"
    end

    context "with dealer_type_id" do
      let(:dealer_detail) { attributes_for(:dealer)[:detail].merge(dealer_type_id: 1) }
      let(:append_attrs_when_build) {{ detail: dealer_detail }}
      let(:args) {{ filter: { dealer_type_id: 1 }}}
      let(:other_args) {{ filter: { dealer_type_id: 2 }}}
      include_examples "resources#index filtered"
    end

    context "with specific_service_id" do
      let(:dealer_detail) { attributes_for(:dealer)[:detail].merge(specific_service_id: 1) }
      let(:append_attrs_when_build) {{ detail: dealer_detail }}
      let(:args) {{ filter: { specific_service_id: 1 }}}
      let(:other_args) {{ filter: { specific_service_id: 2 }}}
      include_examples "resources#index filtered"
    end

    context "with bussiness_scope_id" do
      let(:dealer_detail) { attributes_for(:dealer)[:detail].merge(business_scope_ids: [1]) }
      let(:append_attrs_when_build) {{ detail: dealer_detail }}
      let(:args) {{ filter: { business_scope_id: 1 }}}
      let(:other_args) {{ filter: { business_scope_id: 2 }}}
      include_examples "resources#index filtered"
    end

  end

  describe Api::Accounts::ProvidersController do
    let(:resource) { :provider }

    include_examples "resources#index"
    include_examples "resources#show"
    include_examples "resources#detail"

    context "with query" do
      let(:append_attrs_when_build) {{ username: 'Hello' }}
      let(:args) {{ query: 'Hello' }}
      let(:other_args) {{ query: 'Bye' }}
      include_examples "resources#index filtered"
    end

  end

  describe Api::Accounts::FriendsController do
    context do
      before { 3.times { user.make_friend_with(create(:user)).save }}

      include_examples "resources#collection", :index

      describe "GET user" do
        include_examples "resources#collection", :user
      end
      
      describe "with user_id" do
        let(:args) {{ user_id: user.id }}
        include_examples "resources#collection", :index
      end
    end

    describe "GET dealer" do
      before { 3.times { user.make_friend_with(create(:dealer)).save }}
      include_examples "resources#collection", :dealer
    end

    describe "GET provider" do
      before { 3.times { user.make_friend_with(create(:provider)).save }}
      include_examples "resources#collection", :provider
    end
    
    context do
      before { user.make_friend_with(other).save }
      let(:args) {{ id: other.id }}
      include_examples "resources#post", :create
      include_examples "resources#delete", :destroy
    end
  end

  describe Api::Accounts::BlacklistsController do
    context do
      before { 3.times { user.add_to_blacklist(create(:user)).save }}

      include_examples "resources#collection", :index
      
      describe "with user_id" do
        let(:args) {{ user_id: user.id }}
        include_examples "resources#collection", :index
      end
    end
    
    context do
      before { user.add_to_blacklist(other).save }
      let(:args) {{ id: other.id }}
      include_examples "resources#post", :create
      include_examples "resources#delete", :destroy
    end
  end
end
