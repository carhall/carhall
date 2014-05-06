module WeixinFormatter
  def self.call(object, env)
    ret = case object
    when Hash
      case object.keys.first
      when :news
        format_news object[:news]
      end
    when String
      format_text object
    end
    Rails.logger.info("Request: #{env["grape.request.params"]["xml"]}")
    Rails.logger.info("Response object: #{object.inspect}")
    Rails.logger.info("Response: \n#{ret}")
    ret
  end

  def self.format_text text
    params = env["grape.request.params"]["xml"]
    {
      ToUserName:   params["FromUserName"],
      FromUserName: params["ToUserName"],
      CreateTime:   Time.now.to_i,
      MsgType:      "text",
      Content:      text,
    }.to_xml(root: "xml", skip_types: true)
  end

  def self.format_news news
    params = env["grape.request.params"]["xml"]
    if news.kind_of? Array
      {
        ToUserName:   params["FromUserName"],
        FromUserName: params["ToUserName"],
        CreateTime:   Time.now.to_i,
        MsgType:      "news",
        ArticleCount: news.count,
        Articles:     news,
      }.to_xml(root: "xml", children: 'item', skip_types: true)
    else
      {
        ToUserName:   params["FromUserName"],
        FromUserName: params["ToUserName"],
        CreateTime:   Time.now.to_i,
        MsgType:      "news",
        ArticleCount: 1,
        Articles:     { item: news },
      }.to_xml(root: "xml", skip_types: true)
    end
  end
end
