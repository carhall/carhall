require 'spec_helper'

describe Api::UsersController do
  include_context "for devise"

  let(:resource_name) { :user }

  include_examples "resources#show"
  include_examples "resources#detail"
  include_examples "resources#create"

  describe "POST login" do
    it "has a 201 status code" do
      post :login, data: { mobile: user.mobile, password: user.password }
      expect(response.status).to eq(201)
    end
  end
end

describe Api::CurrentUsersController do
  include_context "for devise"

  let(:resource_name) { :user }

  include_examples "resource#show"
  include_examples "resource#detail"
  include_examples "resource#update"

  describe "PUT password" do
    describe "without current_password" do
      it "has a 422 status code" do
        put :password, data: attributes
        expect(response.status).to eq(422)
      end
    end
    describe "with current_password" do
      it "has a 202 status code" do
        put :password, data: attributes.merge(current_password: "password")
        expect(response.status).to eq(202)
      end
    end
  end
end

describe Api::DealersController do
  include_context "for devise"

  let(:resource_name) { :dealer }

  include_examples "resources#index"
  include_examples "resources#show"
  include_examples "resources#detail"
end

describe Api::ProvidersController do
  include_context "for devise"

  let(:resource_name) { :provider }

  include_examples "resources#index"
  include_examples "resources#show"
  include_examples "resources#detail"
end

describe Api::FriendsController do
  include_context "for devise"

  let(:resource_name) { :user }

  before { 3.times { user.make_friend_with(create(:user)).save }}

  include_examples "resources#index"
  context "with user_id" do
    let(:attach_args) {{ user_id: user.id }}
    include_examples "resources#index"
  end
  context do
    let(:reset_args) {{ id: id }}
    include_examples "resources#create"
  end
  include_examples "resources#destroy"
end

describe Api::BlacklistsController do
  include_context "for devise"

  let(:resource_name) { :user }

  before { 3.times { user.add_to_blacklist(create(:user)).save }}

  include_examples "resources#index"
  context do
    let(:reset_args) {{ id: id }}
    include_examples "resources#create"
  end
  include_examples "resources#destroy"
end
