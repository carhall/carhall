class WeixinAPI < Grape::API
  class Get < Grape::API
    format :txt

    before do
      error! '403 Forbidden', 403 unless check_signature
    end

    desc 'Check weixin sign'
    params do
      requires :signature, :timestamp, :nonce, :echostr
    end
    get ":id" do
      Thread.new do
        sleep 5
        initialize_weixin_account params[:account]
      end
      params[:echostr]
    end
  end

  class Post < Grape::API
    format :xml
    formatter :xml, WeixinFormatter
    content_type :xml, "text/xml"

    before do
      error! '403 Forbidden', 403 unless check_signature
    end

    desc 'weixin response'
    params do
      requires :signature, :timestamp, :nonce
    end
    post ":id" do
      status 200
      respond_weixin params[:account], params["xml"]
    end
  end

  class Helper < Grape::API
    content_type :txt, "application/json"

    desc 'weixin create menu'
    get ":id/create_menu" do
      create_menu params[:account]
    end

    desc 'weixin get menu'
    get ":id/get_menu" do
      generate_menu params[:account]
    end

    desc 'weixin get mine'
    get ":id/get_mine" do
      generate_mine params[:account]
    end
  end

  version 'v1', using: :param

  helpers WeixinHelper

  before do
    set_account
  end

  mount WeixinAPI::Helper
  mount WeixinAPI::Get
  mount WeixinAPI::Post
end
