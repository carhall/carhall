module WeixinHelper

  def respond_weixin account, params
    case params["MsgType"]
    when "event"
      respond_event account, params
    when ""

    end
  end

  def respond_event account, params
    case params["EventKey"]
    when "vip_card"
      format_resources_to_news account, account.vip_cards
    when "cleaning"
      format_resources_to_news account, account.cleanings
    when "mending"
      format_to_news ::Tips::Mending.model_name.human, 
        "点击查看#{::Tips::Mending.model_name.human}详细资料", 
        account.avatar, 
        "weixin/dealers/#{account.id}/mending"
    when "bulk_purchasing"
      format_resources_to_news account, account.bulk_purchasings
    when "activity"
      format_resources_to_news account, account.activities
    when "dealer_description"
      format_to_news "商家介绍", 
        account.description, 
        account.avatar, 
        "weixin/dealers/#{account.id}"
    when "mine"
      {
        news: [
          {
            Title: "个人资料",
            Description: "点击查看我的详细资料",
            PicUrl: absolute_url("weixin/current_user.png"),
            Url: absolute_url("weixin/current_user")
          }, {
            Title: "会员卡",
            Description: "点击查看我的会员卡详细资料",
            PicUrl: absolute_url("weixin/vip_cards.png"),
            Url: absolute_url("weixin/current_user/vip_cards")
          }, {
            Title: "消费记录",
            Description: "点击查看我的消费记录详细资料",
            PicUrl: absolute_url("weixin/operating_records.png"),
            Url: absolute_url("weixin/current_user/operating_records")
          }
        ]
      }
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

  def format_resources_to_news account, resources
    resource = resources.first
    format_to_news resource.class.model_name.human, 
      "点击查看#{resource.class.model_name.human}详细资料", 
      resource.image, 
      "weixin/dealers/#{account.id}/#{resource.class.name.demodulize.tableize}"
  end


  def initialize_weixin_account
    Thread.new do
      sleep 5
      account = params[:account]
      create_menu WeixinMenu if account.weixin_app_id
    end
  end

  def check_signature
    account = params[:account] = ::Accounts::Account.find(params[:id])
    token = account.weixin_token
    array = [token, params[:timestamp], params[:nonce]].sort
    params[:signature] == Digest::SHA1.hexdigest(array.join)
  end

  def access_token
    Rails.cache.fetch :access_token, expires_in: 1.hours do
      account = params[:account]
      app_id = account.try(:weixin_app_id)
      app_secret = account.try(:weixin_app_secret)
      response = RestClient.get "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{app_id}&secret=#{app_secret}"
      JSON.parse(response.to_str)["access_token"]
    end
  end

  def create_menu menu=WeixinMenu
    response = RestClient.post "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=#{access_token}", menu.to_json
  end

  WeixinMenu = { 
    button: [{
      name: "项目菜单",
      sub_button: [{
        type: "click",
        name: "会员卡",
        key: "vip_card"
      }, {
        type: "click",
        name: "服务项目",
        key: "cleaning"
      }, {
        type: "click",
        name: "保养专修",
        key: "mending"
      }]
    }, {
      name: "发现",
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
      name: "在下",
      sub_button: [{
        type: "click",
        name: "商家介绍",
        key: "dealer_description"
      }, {
        type: "click",
        name: "我的",
        key: "mine"
      }, {
        type: "view",
        name: "手机会员卡",
        url: "http://a.app.qq.com/o/simple.jsp?pkgname=com.kapp.net.carhall&g_f=991653"
      }]
    }]
  }

end