Grape::Entity.format_with :image do |image|
  if image.present?
    {
      original_url: "#{AbsoluteUrlPrefix}#{image.url(:original, timestamp: false)}",
      medium_url: "#{AbsoluteUrlPrefix}#{image.url(:medium, timestamp: false)}",
      thumb_url: "#{AbsoluteUrlPrefix}#{image.url(:thumb, timestamp: false)}",
    }
  else
    nil
  end
end