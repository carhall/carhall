load 'config/routes/backend_route.rb'
load 'config/routes/weixin_route.rb'
load 'config/routes/api_route.rb'

Carhall::Application.routes.draw do

  # Download APP
  get 'Carhall', format: :apk, to: "dashboards#download_apk"

  post '*foo', format: :do, to: ->(env) { [404, {}, []] }
end
