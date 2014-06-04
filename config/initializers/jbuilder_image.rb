AbsoluteUrlPrefix = ENV['CARHALL_URL_PREFIX'] || "http://localhost:3000"

Jbuilder.class_eval do
  def image! object, image
    if object.send(image).present?
      set! :"#{image}_url", "#{AbsoluteUrlPrefix}#{object.send(image).url(:original,timestamp:false)}"
      set! :"#{image}_medium_url", "#{AbsoluteUrlPrefix}#{object.send(image).url(:medium,timestamp:false)}"
      set! :"#{image}_thumb_url", "#{AbsoluteUrlPrefix}#{object.send(image).url(:thumb,timestamp:false)}"
    else
      set! :"#{image}_url", nil
      set! :"#{image}_medium_url", nil
      set! :"#{image}_thumb_url", nil
    end
  end

  def builder! object, association, builder
    association_object = object.send(association)
    if association_object
      set! association, association_object.send(:"to_#{builder}_builder")
    else
      set! association, nil
    end
  end
  
  # Merges hash or array into current builder.
  def merge!(hash_or_array)
    if ::Array === hash_or_array
      @attributes = [] unless ::Array === @attributes
      @attributes.concat hash_or_array
    else
      @attributes.update hash_or_array
    end
  end
  
end