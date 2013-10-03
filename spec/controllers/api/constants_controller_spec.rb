require 'spec_helper'

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