require 'spec_helper'

describe AssistantAPI do

  let(:user) { create :dealer }
  let(:auth_token) { user.authentication_token }

  describe Accounts::LoginAPI do
    describe "POST /assistant/login" do
      it "returns a 201 status code" do
        post "/assistant/login", data: { mobile: user.mobile, password: user.password }
        response.status.should == 201
      end
    end
  end

  describe Accounts::CurrentUserAPI do
    describe "GET /assistant/current_user" do
      it "returns the current login user" do
        get "/assistant/current_user?auth_token=#{auth_token}"
        response.status.should == 200
      end
    end
  end

  describe Tips::VipCardOrderAPI do
    describe "GET /assistant/vip_card_orders" do
      it "returns an array of vip card orders" do
        get "/assistant/vip_card_orders?auth_token=#{auth_token}"
        response.status.should == 200
      end
    end
  end

  describe Statistic::OperatingRecordAPI do
    describe "GET /assistant/operating_records" do
      it "returns an array of operating records" do
        get "/assistant/operating_records?auth_token=#{auth_token}"
        response.status.should == 200
      end
    end
  end

  describe Statistic::SalesCaseAPI do
    describe "GET /assistant/sales_cases" do
      it "returns an array of sales cases" do
        get "/assistant/sales_cases?auth_token=#{auth_token}"
        response.status.should == 200
      end
    end
  end

  describe Statistic::UserInfoAPI do
    describe "GET /assistant/user_infos" do
      it "returns an array of user infos" do
        get "/assistant/user_infos?auth_token=#{auth_token}"
        response.status.should == 200
      end
    end
  end
end