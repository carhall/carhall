class WeixinAPI < Grape::API
  class Get < Grape::API
    format :txt
    desc 'Check weixin sign'
    params do
      requires :signature, :timestamp, :nonce, :echostr
    end
    get ":id" do
      initialize_weixin_account
      params[:echostr]
    end
  end

  class Post < Grape::API
    format :xml
    formatter :xml, WeixinFormatter
    content_type :xml, "text/xml"

    desc 'weixin response'
    params do
      requires :signature, :timestamp, :nonce
    end
    post ":id" do
      status 200
      respond_weixin params[:account], params["xml"]
    end
  end

  version 'v1', using: :param

  before do
    error! '403 Forbidden', 403 unless check_signature
  end

  helpers do
    def respond_weixin(account, params)
      case params["MsgType"]
      when "event"
        respond_event account, params
      when ""

      end
    end

    def respond_event(account, params)
      case params["EventKey"]
      when "vip_card"
        format_resources_to_news account, account.vip_cards
      when "cleaning"
        format_resources_to_news account, account.cleanings
      when "mending"
        format_to_news ::Tips::Mending.model_name.human, 
          "点击查看#{I18n.t("#{::Tips::Mending.model_name.human}")}详细资料", 
          account.avatar, 
          "dealers/#{account.id}/#{::Tips::Mending.model_name.collection}"
      when "bulk_purchasing"
        format_resources_to_news account, account.bulk_purchasings
      when "activity"
        format_resources_to_news account, account.activities
      when "dealer_description"
        format_to_news "商家介绍", 
          account.description, 
          account.avatar, 
          "dealers/#{account.id}"
      when "download_app"
        ""
      when "my_vip_card"
        ""
      end
    end

    def format_to_news title, description, image, url
      {
        news: {
          Title: title,
          Description: description,
          PicUrl: image.url(:original),
          Url: absolute_url(url)
        }
      }
    end

    def format_resources_to_news account, resources, description
      resource = resources.first
      format_to_news resource.class.model_name.human, 
        "点击查看#{I18n.t("#{resource.class.model_name.human}")}详细资料", 
        resource.image, 
        "dealers/#{account.id}/#{resource.class.model_name.collection}"
    end


    def initialize_weixin_account
      Thread.new do
        sleep 5
        create_menu WeixinMenu
      end
    end

    def check_signature
      account = params[:account] = ::Accounts::Account.find(params[:id])
      token = account.authentication_token
      array = [token, params[:timestamp], params[:nonce]].sort
      params[:signature] == Digest::SHA1.hexdigest(array.join)
    end

    def access_token
      Rails.cache.fetch :access_token, expires_in: 1.hours do
        app_id = "wx46c1198fe2a43173"
        app_secret = "459f6ee22762db6455023a7ad52c3c20"
        response = RestClient.get "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{app_id}&secret=#{app_secret}"
        JSON.parse(response.to_str)["access_token"]
      end
    end

    def create_menu menu
      response = RestClient.post "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=#{access_token}", menu.to_json
    end
  end

  mount WeixinAPI::Get
  mount WeixinAPI::Post    
end

WeixinMenu = { 
  button: [{
    name: "服务项目",
    sub_button: [{
      type: "click",
      name: "会员卡",
      key: "vip_card"
    }, {
      type: "click",
      name: "项目菜单",
      key: "cleaning"
    }, {
      type: "click",
      name: "保养专修",
      key: "mending"
    }]
  }, {
    name: "促销",
    sub_button: [{
      type: "click",
      name: "近期团购",
      key: "bulk_purchasing"
    }, {
      type: "click",
      name: "近期活动",
      key: "activity"
    }]
  }, {
    name: "更多",
    sub_button: [{
      type: "click",
      name: "商家介绍",
      key: "dealer_description"
    }, {
      type: "click",
      name: "汽车堂下载",
      key: "download_app"
    }, {
      type: "click",
      name: "我的会员卡",
      key: "my_vip_card"
    }]
  }]
}