def absolute_image_url image, type
  "#{AbsoluteUrlPrefix}#{image.url(type, timestamp: false)}"
end

module Paperclip
  class HashieMashUploadedFileAdapter < AbstractAdapter

    def initialize(target)
      @tempfile, @content_type, @size = target.tempfile, target.type, target.tempfile.size
      self.original_filename = target.filename
    end

  end
end

Paperclip.io_adapters.register Paperclip::HashieMashUploadedFileAdapter do |target|
  target.is_a? Hashie::Mash
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
