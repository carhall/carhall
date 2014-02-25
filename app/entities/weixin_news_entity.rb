class WeixinNewsEntity < Grape::Entity
  expose :Title do |resource, options|
    resource.title
  end
  expose :Description do |resource, options|
    resource.description
  end
  expose :PicUrl do |resource, options|
    "#{AbsoluteUrlPrefix}#{resource.image.url(:thumb, timestamp: false)}"
  end
  expose :Url do |resource, options|
    "url"
  end
end
