module WeixinFormatter
  def self.call(object, env)
    params = env["grape.request.params"]["xml"]
    {
      ToUserName:   params["FromUserName"],
      FromUserName: params["ToUserName"],
      CreateTime:   Time.now.to_i,
      MsgType:      "news",
      ArticleCount: object.count,
      Articles:     object,
    }.to_xml(root: "xml", children: 'item', skip_types: true)
  end
end