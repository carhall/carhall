def absolute_image_url image, type
  "#{AbsoluteUrlPrefix}#{image.url(type, timestamp: false)}"
end

Grape::Entity.class_eval do
  format_with :image do |image|
    if image.present?
      {
        original_url: absolute_image_url(image, :original),
        medium_url: absolute_image_url(image, :medium),
        thumb_url: absolute_image_url(image, :thumb),
      }
    else
      nil
    end
  end
end
