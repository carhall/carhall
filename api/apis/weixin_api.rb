class WeixinAPI < Grape::API
  class Get < Grape::API
    format :txt

    get ":id/create_menu" do
      create_menu
    end
    
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

  helpers WeixinHelper

  mount WeixinAPI::Get
  mount WeixinAPI::Post
end
