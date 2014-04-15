class WeixinNewsEntity < Grape::Entity
  root :news, :news
  
  expose :Title do |resource, options|
    resource.title
  end
  expose :Description do |resource, options|
    resource.description
  end
  expose :PicUrl do |resource, options|
    unless options[:env][:WeixinNews]
      options[:env][:WeixinNews] = true
      absolute_image_url(resource.image, :original)
    else
      absolute_image_url(resource.image, :thumb)
    end
  end
  expose :Url do |resource, options|
    absolute_url("weixin/#{resource.class.name.tableize}/#{resource.id}")
  end
end
