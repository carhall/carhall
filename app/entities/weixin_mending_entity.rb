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
      absolute_image_url(resource.dealer.avatar, :original)
    else
      absolute_image_url(resource.dealer.avatar, :thumb)
    end
  end
  expose :Url do |resource, options|
    "url"
  end
end
