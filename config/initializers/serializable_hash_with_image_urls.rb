ActiveModel::Serialization.module_eval do

  def serializable_hash(options={})
    attribute_names = attributes.keys.sort
    if only = options[:only]
      attribute_names &= Array.wrap(only).map(&:to_s)
    elsif except = options[:except]
      attribute_names -= Array.wrap(except).map(&:to_s)
    end

    hash = {}
    attribute_names.each { |n| hash[n] = read_attribute_for_serialization(n) }

    Array.wrap(options[:methods]).each { |n| hash[n] = send(n) if respond_to?(n) }

    absolute_url_prefix = Carhall::AbsoluteUrlPrefix 

    Array.wrap(options[:images]).each do |n| 
      if respond_to?(n) and (image = send(n)).kind_of? Paperclip::Attachment
        if image.present?
          hash["#{n}_url"] = "#{absolute_url_prefix}#{image.url(:original)}"
          hash["#{n}_medium_url"] = "#{absolute_url_prefix}#{image.url(:medium)}"
          hash["#{n}_thumb_url"] = "#{absolute_url_prefix}#{image.url(:thumb)}"
        else
          hash["#{n}_url"] = hash["#{n}_medium_url"] = hash["#{n}_thumb_url"] = nil
        end
      end
    end

    serializable_add_includes(options) do |association, records, opts|
      hash[association] = if records.is_a?(Enumerable)
        records.map { |a| a.serializable_hash(opts) }
      else
        records.serializable_hash(opts)
      end
    end

    hash
  end

  private

  def serializable_add_includes(options = {}) #:nodoc:
    return unless include = options[:include]

    unless include.is_a?(Hash)
      include = Hash[Array.wrap(include).map { |n| n.is_a?(Hash) ? n.to_a.first : [n, {}] }]
    end

    include.each do |association, opts|
      if records = send(association)
        yield association, records, opts.merge(source: self)
      end
    end
  end

end