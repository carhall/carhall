class WeixinMendingEntity < Grape::Entity
  root :news, :news
  
  expose :Title do |resource, options|
    "#{resource.dealer.username} 保养专修"
  end
  expose :Description do |resource, options|
    resource.description
  end
  expose :PicUrl do |resource, options|
    unless options[:env][:WeixinNews]
      options[:env][:WeixinNews] = true
      "#{AbsoluteUrlPrefix}#{resource.dealer.avatar.url(:original, timestamp: false)}"
    else
      "#{AbsoluteUrlPrefix}#{resource.dealer.avatar.url(:thumb, timestamp: false)}"
    end
  end
  expose :Url do |resource, options|
    "url"
  end
end
