require 'spec_helper'

describe OpenfiresController do
  include_context "shared context"

  before { @user = create(:user) }

  it "has a 200 status code, and return a array" do
    post :login, { mobile: @user.mobile, password: 'password' }
    response.status.should eq(200), error_messages

    response_body['data'].should (be_kind_of Hash), error_messages
  end

  it "has a 200 status code" do
    post :login_by_token, { token: @user.authentication_token }
    response.status.should eq(200), error_messages

    response_body['data'].should (be_kind_of Hash), error_messages
  end

  it "has a 200 status code" do
    post :get_user, { id: @user.id }
    response.status.should eq(200), error_messages

    response_body['data'].should (be_kind_of Hash), error_messages
  end
  
  it "has a 200 status code" do
    post :list_users, { ids: @user.id }
    response.status.should eq(200), error_messages

    response_body['data'].should (be_kind_of Hash), error_messages
  end
end