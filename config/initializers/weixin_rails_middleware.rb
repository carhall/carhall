# Use this hook to configure WeixinRailsMiddleware bahaviors.
WeixinRailsMiddleware.configure do |config|

  ## NOTE:
  ## If you config all them, it will use `weixin_token_string` default

  ## Config public_account_class if you SAVE public_account into database ##
  # Th first configure is fit for your weixin public_account is saved in database.
  # +public_account_class+ The class name that to save your public_account
  # config.public_account_class = "PublicAccount"

  ## Here configure is for you DON'T WANT TO SAVE your public account into database ##
  # Or the other configure is fit for only one weixin public_account
  # If you config `weixin_token_string`, so it will directly use it
   config.weixin_token_string = 'b456fd23b819a99bf87a2afa'
  # using to weixin server url to validate the token can be trusted.
   config.weixin_secret_string = '83znm1Bxcn3HQQUM8mA9_IWBTZHvPkc8'

  ## You can custom your adapter to validate your weixin account ##
  # Wiki https://github.com/lanrion/weixin_rails_middleware/wiki/Custom-Adapter
  #config.custom_adapter = "MyCustomAdapter"

end
$c_host="http://weixin-sgd.ngrok.com/"

$cheyouhui ||= WeixinAuthorize::Client.new("wx83933024d937981d", "44bceaa831c4d3c18c5225232315ec5b")
