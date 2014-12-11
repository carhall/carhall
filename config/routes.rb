load 'config/routes/backend_route.rb'
load 'config/routes/weixin_route.rb'
load 'config/routes/api_route.rb'
load 'config/routes/cheyouhui.rb'

Carhall::Application.routes.draw do



  mount WeixinRailsMiddleware::Engine, at: "/",path: "cheyouhui"
  # Download APP
  get 'Carhall', format: :apk, to: "dashboards#download_apk"

  post '*foo', format: :do, to: ->(env) { [404, {}, []] }
end
