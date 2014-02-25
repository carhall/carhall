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
      "#{AbsoluteUrlPrefix}#{resource.image.url(:original, timestamp: false)}"
    else
      "#{AbsoluteUrlPrefix}#{resource.image.url(:thumb, timestamp: false)}"
    end
  end
  expose :Url do |resource, options|
    "url"
  end
end
