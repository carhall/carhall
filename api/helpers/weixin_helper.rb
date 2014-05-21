module WeixinHelper

  def respond_weixin account, params
    case params["MsgType"]
    when "event"
      respond_event account, params
    when ""

    end
  end

  def respond_event account, params
    case params["Event"]
    when "CLICK", "VIEW"
      response_menu_event account, params
    when "subscribe"
      account.try(:weixin_welcome)
    end
  end

  def response_menu_event account, params
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
    when "rescue"
      format_to_news "故障救援", 
        "一键救援，紧急联系你的专属客服", 
        absolute_url("weixin/rescue.png"), 
        "weixin/dealers/#{account.id}/rescue"
    when "vehicle_insurance"
      format_to_news "车险续保", 
        "你不懂的可以让专业人士解答", 
        absolute_url("weixin/vehicle_insurance.png"), 
        "weixin/dealers/#{account.id}/vehicle_insurance/orders/new"
    when "secondhand_appraise"
      format_to_news "爱车评估", 
        "专业值得信赖的机构\n想换车，先评估一下吧", 
        absolute_url("weixin/secondhand_appraise.png"), 
        "weixin/dealers/#{account.id}/secondhand_appraise/orders/new"
    when "test_drive"
      format_to_news "新车展厅", 
        "点击可查看车型报价、参数等详细资料", 
        account.test_drives.first.image, 
        "weixin/dealers/#{account.id}/test_drives"
    when "mine"
      generate_mine account
    end
  end

  def format_to_news title, description, image, url
    {
      news: {
        Title: title,
        Description: description,
        PicUrl: (absolute_url(image.url(:medium)) rescue image),
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

  def initialize_weixin_account account
    create_menu account if account.weixin_app_id
  end

  def set_account
    params[:account] ||= ::Accounts::Account.find(params[:id])
  end

  def check_signature
    account = params[:account]
    token = account.weixin_token
    array = [token, params[:timestamp], params[:nonce]].sort
    params[:signature] == Digest::SHA1.hexdigest(array.join)
  end

  def access_token account
    # Rails.cache.fetch :access_token, expires_in: 1.hours do
      app_id = account.try(:weixin_app_id)
      app_secret = account.try(:weixin_app_secret)
      response = RestClient.get "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{app_id}&secret=#{app_secret}"
      JSON.parse(response.to_str)["access_token"]
    # end
  end
  
  def create_menu account, menu=generate_menu(account)
    request_weixin account, 'menu/create', menu
  end

  def request_weixin account, command, data
    weixin_service_url = "https://api.weixin.qq.com/cgi-bin/#{command}?access_token=#{access_token(account)}"
    backup_escape = ActiveSupport::JSON::Encoding.escape_html_entities_in_json
    response = nil

    begin
      ActiveSupport::JSON::Encoding.escape_html_entities_in_json = false
      Rails.logger.info("  Requested Weixin #{command} API #{weixin_service_url}")
      response = RestClient.post weixin_service_url, data.to_json
      Rails.logger.info("  Result: #{response}")
    rescue Exception => e
      Rails.logger.info("  Error occurred when requesting weixin api: #{e}")
    ensure
      ActiveSupport::JSON::Encoding.escape_html_entities_in_json = backup_escape
      response
    end
  end

  def generate_menu account
    case account
    when Accounts::Dealer
      case account.dealer_type
      when "洗车美容"
        { 
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
            }]
          }, {
            name: "发现",
            sub_button: [{
              type: "click",
              name: "团购",
              key: "bulk_purchasing"
            }, {
              type: "click",
              name: "活动",
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
              name: "违章查询",
              url: "http://sms100.sinaapp.com/all/"
            }, {
              type: "view",
              name: "手机会员卡",
              url: "http://a.app.qq.com/o/simple.jsp?pkgname=com.kapp.net.carhall&g_f=991653"
            }]
          }]
        }
      when "4S店"
        { 
          button: [{
            name: "项目菜单",
            sub_button: [{
              type: "click",
              name: "故障救援",
              key: "rescue"
            }, {
              type: "click",
              name: "车险续保",
              key: "vehicle_insurance"
            }, {
              type: "click",
              name: "保养维修",
              key: "mending"
            }]
          }, {
            name: "发现",
            sub_button: [{
              type: "click",
              name: "团购",
              key: "bulk_purchasing"
            }, {
              type: "click",
              name: "活动",
              key: "activity"
            }, {
              type: "click",
              name: "爱车估价",
              key: "secondhand_appraise"
            }, {
              type: "click",
              name: "看车试驾",
              key: "test_drive"
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
              name: "违章查询",
              url: "http://sms100.sinaapp.com/all/"
            }]
          }]
        }
      when "汽车销售"
        { 
          button: [{
            name: "项目菜单",
            sub_button: [{
              type: "click",
              name: "爱车估价",
              key: "secondhand_appraise"
            }, {
              type: "click",
              name: "看车试驾",
              key: "test_drive"
            }, {
              type: "click",
              name: "车险续保",
              key: "vehicle_insurance"
            }, {
              type: "view",
              name: "违章查询",
              url: "http://sms100.sinaapp.com/all/"
            }]
          }, {
            name: "发现",
            sub_button: [{
              type: "click",
              name: "团购",
              key: "bulk_purchasing"
            }, {
              type: "click",
              name: "活动",
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
            }]
          }]
        }
      when "专修"
        { 
          button: [{
            name: "项目菜单",
            sub_button: [{
              type: "click",
              name: "故障救援",
              key: "rescue"
            }, {
              type: "click",
              name: "车险续保",
              key: "vehicle_insurance"
            }, {
              type: "click",
              name: "保养维修",
              key: "mending"
            }]
          }, {
            name: "发现",
            sub_button: [{
              type: "click",
              name: "团购",
              key: "bulk_purchasing"
            }, {
              type: "click",
              name: "活动",
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
              name: "违章查询",
              url: "http://sms100.sinaapp.com/all/"
            }]
          }]
        }
      end
    end
  end

  def generate_mine account
    case account
    when Accounts::Dealer
      case account.dealer_type
      when "洗车美容"
        {
          news: [
            {
              Title: "个人资料",
              Description: "点击查看我的详细资料",
              PicUrl: absolute_url("weixin/current_user.png"),
              Url: absolute_url("weixin/dealers/#{account.id}/current_user")
            }, {
              Title: "会员卡",
              Description: "点击查看我的会员卡详细资料",
              PicUrl: absolute_url("weixin/arrow_right.png"),
              Url: absolute_url("weixin/dealers/#{account.id}/current_user/vip_card/orders")
            }, {
              Title: "消费记录",
              Description: "点击查看我的消费记录详细资料",
              PicUrl: absolute_url("weixin/arrow_right.png"),
              Url: absolute_url("weixin/dealers/#{account.id}/current_user/consumption_records")
            }, {
              Title: "提醒服务",
              Description: "点击查看我的提醒服务详细资料",
              PicUrl: absolute_url("weixin/arrow_right.png"),
              Url: absolute_url("weixin/dealers/#{account.id}/current_user/sales_cases")
            }
          ]
        }
      when "4S店", "专修"
        {
          news: [
            {
              Title: "个人资料",
              Description: "点击查看我的详细资料",
              PicUrl: absolute_url("weixin/current_user.png"),
              Url: absolute_url("weixin/dealers/#{account.id}/current_user")
            }, {
              Title: "预约订单",
              Description: "点击查看我的会员卡详细资料",
              PicUrl: absolute_url("weixin/arrow_right.png"),
              Url: absolute_url("weixin/dealers/#{account.id}/current_user/mending/orders")
            }, {
              Title: "团购订单",
              Description: "点击查看我的消费记录详细资料",
              PicUrl: absolute_url("weixin/arrow_right.png"),
              Url: absolute_url("weixin/dealers/#{account.id}/current_user/bulk_purchasing/orders")
            }, {
              Title: "提醒服务",
              Description: "点击查看我的提醒服务详细资料",
              PicUrl: absolute_url("weixin/arrow_right.png"),
              Url: absolute_url("weixin/dealers/#{account.id}/current_user/sales_cases")
            }
          ]
        }
      when "汽车销售"
        {
          news: [
            {
              Title: "个人资料",
              Description: "点击查看我的详细资料",
              PicUrl: absolute_url("weixin/current_user.png"),
              Url: absolute_url("weixin/dealers/#{account.id}/current_user")
            }, {
              Title: "提醒服务",
              Description: "点击查看我的提醒服务详细资料",
              PicUrl: absolute_url("weixin/arrow_right.png"),
              Url: absolute_url("weixin/dealers/#{account.id}/current_user/sales_cases")
            }
          ]
        }
      end
    end
  end

end
