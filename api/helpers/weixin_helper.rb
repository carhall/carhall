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
      format_to_news "预约服务",
        "点击查看预约服务详细资料",
        account.avatar,
        "weixin/dealers/#{account.id}/mending"
    when "bulk_purchasing"
      format_resources_to_news account, account.bulk_purchasings
    when "activity"
      format_resources_to_news account, account.activities
    when "rescue"
      format_to_news "故障救援",
        "一键救援，紧急联系你的专属客服",
        "weixin/rescue.png",
        "weixin/dealers/#{account.id}/rescue"
    when "vehicle_insurance"
      format_to_news "车险续保",
        "你不懂的可以让专业人士解答",
        "weixin/vehicle_insurance.png",
        "weixin/dealers/#{account.id}/vehicle_insurance/orders/new"
    when "secondhand_appraise"
      format_to_news "爱车评估",
        "专业值得信赖的机构\n想换车，先评估一下吧",
        "weixin/secondhand_appraise.png",
        "weixin/dealers/#{account.id}/secondhand_appraise/orders/new"
    when "test_driving"
      format_to_news "新车展厅",
        "点击可查看车型报价、参数等详细资料",
        account.test_drivings.first.image,
        "weixin/dealers/#{account.id}/test_drivings"
    when "dealer_description"
      format_to_news "商家介绍",
        account.description,
        account.avatar,
        "weixin/dealers/#{account.id}"
    when "bulk_purchasing2"
      format_resources_to_news account, account.bulk_purchasing2s
    when "manual_image"
      format_to_news "产品图册",
        "点击可查看产品图册，及时了解新品动态",
        account.manual_images.first.image,
        "weixin/distributors/#{account.id}/manual_images"
    when "construction_case"
      account_type = account.type.demodulize.tableize
      format_to_news "案例展示",
        "点击可查看别的小伙伴们都选择了么",
        account.construction_cases.first.image,
        "weixin/#{account_type}/#{account.id}/construction_cases"
    when "ad_template"
      format_to_news "广告模板",
        "点击查看广告模板详细资料",
        account.ad_templates.first.avatar,
        "weixin/distributors/#{account.id}/ad_templates"
    when "buying_advice"
      format_to_news "会买车",
        "一键获得最低价，买车用我更实惠",
        "weixin/buying_advice.png",
        "weixin/current_user/buying_advice"
    when "distributor_description"
      format_to_news "商家介绍",
        account.description,
        account.avatar,
        "weixin/distributors/#{account.id}"
    when "mine"
      generate_mine account
    end
  rescue Exception => e
    "暂无数据"
  end

  def format_to_news title, description, image, url
    {
      news: {
        Title: title,
        Description: description,
        PicUrl: (absolute_url(image.url(:original)) rescue absolute_url(image)),
        Url: absolute_url(url)
      }
    }
  end

  def format_resources_to_news account, resources
    account_type = account.type.demodulize.tableize
    resource = resources.first
    format_to_news resource.class.model_name.human,
      "点击查看#{resource.class.model_name.human}详细资料",
      resource.image,
      "weixin/#{account_type}/#{account.id}/#{resource.class.name.demodulize.tableize}"
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
      Rails.logger.info("  Requested Weixin #{command} API #{weixin_service_url}, with params #{data.to_json}")
      response = RestClient.post weixin_service_url, data.to_json
      Rails.logger.info("  Result: #{response}")
    rescue Exception => e
      Rails.logger.info("  Error occurred when requesting weixin api: #{e}")
    ensure
      ActiveSupport::JSON::Encoding.escape_html_entities_in_json = backup_escape
    end
    response
  end

  def format_to_menu account, data
    button = []
    data.each do |key, value|
      sub_button = value.map do |key|
        next unless account.can_use_template? key
        case key
        when :activity
          { type: "click", name: "活动", key: "activity" }
        when :mending
          { type: "click", name: "预约服务", key: "mending" }
        when :cleaning
          { type: "click", name: "服务项目", key: "cleaning" }
        when :bulk_purchasing
          { type: "click", name: "团购", key: "bulk_purchasing" }
        when :bulk_purchasing2
          { type: "click", name: "团购", key: "bulk_purchasing2" }
        when :vip_card
          { type: "click", name: "会员卡", key: "vip_card" }
        when :secondhand_appraise
          { type: "click", name: "爱车估价", key: "secondhand_appraise" }
        when :test_driving
          { type: "click", name: "看车试驾", key: "test_driving" }
        when :manual_image
          { type: "click", name: "产品图册", key: "manual_image" }
        when :construction_case
          { type: "click", name: "案例展示", key: "construction_case" }
        when :rescue
          { type: "click", name: "故障救援", key: "rescue" }
        when :vehicle_insurance
          { type: "click", name: "车险续保", key: "vehicle_insurance" }
        when :ad_template
          { type: "click", name: "广告模板", key: "ad_template" }
        when :buying_advice
          { type: "click", name: "会买车", key: "buying_advice" }
        when :dealer_description
          { type: "click", name: "商家介绍", key: "dealer_description" }
        when :distributor_description
          { type: "click", name: "商家介绍", key: "distributor_description" }
        when :mine
          { type: "click", name: "我的", key: "mine" }
        when :traffic_violation
          { type: "view", name: "违章查询", url: "http://szupu.szu.edu.cn/szupu/all/index.php" }
        when :download_app
          { type: "view", name: "手机会员卡", url: "http://a.app.qq.com/o/simple.jsp?pkgname=com.kapp.net.carhall&g_f=991653" }
        end
      end.reject(&:nil?)
      button << { name: key, sub_button: sub_button }
    end
    { button: button }
  end

  def generate_menu account
    case account
    when Accounts::Dealer
      case account.dealer_type
      when "洗车美容"
        format_to_menu account, {
          "项目菜单" => [:vip_card, :cleaning, :traffic_violation],
          "发现" => [:bulk_purchasing, :activity, :construction_case, :buying_advice],
          "更多" => [:dealer_description, :mine, :download_app],
        }
      when "4S店"
        format_to_menu account, {
          "项目菜单" => [:rescue, :vehicle_insurance, :mending, :traffic_violation],
          "发现" => [:bulk_purchasing, :activity, :secondhand_appraise, :test_driving],
          "更多" => [:dealer_description, :mine],
        }
      when "汽车销售"
        format_to_menu account, {
          "项目菜单" => [:secondhand_appraise, :test_driving, :vehicle_insurance, :traffic_violation],
          "发现" => [:bulk_purchasing, :activity],
          "更多" => [:dealer_description, :mine],
        }
      when "专修"
        format_to_menu account, {
          "项目菜单" => [:rescue, :vehicle_insurance, :mending, :traffic_violation],
          "发现" => [:bulk_purchasing, :activity],
          "更多" => [:dealer_description, :mine],
        }
      when "专项服务"
        format_to_menu account, {
          "项目菜单" => [:cleaning, :traffic_violation],
          "发现" => [:bulk_purchasing, :activity, :buying_advice],
          "更多" => [:dealer_description, :mine, :download_app],
        }
      end
    when Accounts::Distributor
      format_to_menu account, {
        "项目菜单" => [:manual_image, :ad_template],
        "发现" => [:bulk_purchasing2, :construction_case],
        "更多" => [:distributor_description, :mine],
      }
    end
  end

  def format_to_mine account, data
    news = data.map do |key|
      case key
      when :current_user
        format_to_news "个人资料", "点击查看我的详细资料", "weixin/current_user.png",  "weixin/current_user"
      when :current_dealer
        format_to_news "个人资料", "点击查看我的详细资料", "weixin/current_user.png",  "weixin/current_dealer"
      when :vip_card_order
        format_to_news "会员卡", "点击查看我的会员卡详细资料", "weixin/arrow_right.png", "weixin/dealers/#{account.id}/current_user/vip_card/orders"
      when :consumption_record
        format_to_news "消费记录", "点击查看我的消费记录详细资料", "weixin/arrow_right.png", "weixin/dealers/#{account.id}/current_user/consumption_records"
      when :sales_case
        format_to_news "提醒服务", "点击查看我的提醒服务详细资料", "weixin/arrow_right.png", "weixin/dealers/#{account.id}/current_user/sales_cases"
      when :mending_order
        format_to_news "预约订单", "点击查看我的会员卡详细资料", "weixin/arrow_right.png", "weixin/dealers/#{account.id}/current_user/mending/orders"
      when :bulk_purchasing_order
        format_to_news "团购订单", "点击查看我的消费记录详细资料", "weixin/arrow_right.png", "weixin/dealers/#{account.id}/current_user/bulk_purchasing/orders"
      end.fetch :news
    end
    { news: news }
  end

  def generate_mine account
    case account
    when Accounts::Dealer
      case account.dealer_type
      when "洗车美容"
        format_to_mine account, [:current_user, :vip_card_order, :consumption_record, :sales_case]
      when "4S店", "专修"
        format_to_mine account, [:current_user, :mending_order, :bulk_purchasing_order, :sales_case]
      when "汽车销售", "专项服务"
        format_to_mine account, [:current_user, :sales_case]
      end
    when Accounts::Distributor
      format_to_mine account, [:current_dealer]
    end
  end

end
