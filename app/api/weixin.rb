module Weixin
  class Get < Grape::API
    format :txt
    desc 'Check weixin sign'
    get do
      params[:echostr]
    end
  end

  class Post < Grape::API
    format :xml
    content_type :xml, "text/xml"

    desc 'weixin response'
    post do
      
    end
  end

  class API < Grape::API
    version 'v1', using: :param

    before do
      weixin_token = 1
      array = [weixin_token, params[:timestamp], params[:nonce]].sort
      error! '403 Forbidden', 403 unless params[:signature] != Digest::SHA1.hexdigest(array.join)
    end

    mount Weixin::Get
    mount Weixin::Post    
  end
end
