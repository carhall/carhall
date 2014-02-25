module WeixinFormatter
  def self.call(object, env)
    params = env["grape.request.params"]["xml"]
    case object
    when Hash
      case object.keys.first
      when :news
        format_news object[:news], params
      end
    when String
      
    end
  end

  def self.format_news news, params
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