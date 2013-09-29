module ActsAsApi
  ApiTemplate.class_eval do
    attr_reader :serializable_options

    def initialize(api_template)
      super
      @options ||= {}
      @serializable_options ||= {}
    end

    def merge!(other_hash, &block)
      super
      self.options.merge!(other_hash.options) if other_hash.respond_to?(:options)
      self.serializable_options.merge!(other_hash.serializable_options) if other_hash.respond_to?(:serializable_options)
    end

    def insert(array)
      array.each do |val|
        add val
      end
    end

    def include(*array)
      @serializable_options[:include] ||= []
      @serializable_options[:include] += array
    end

    def methods(*array)
      @serializable_options[:methods] ||= []
      @serializable_options[:methods] += array
    end

    def only(*array)
      @serializable_options[:only] ||= []
      @serializable_options[:only] += array
    end
    
    def except(*array)
      @serializable_options[:except] ||= []
      @serializable_options[:except] += array
    end
    
    def images(*array)
      @serializable_options[:images] ||= []
      @serializable_options[:images] += array
    end

    def serializable key, value
      @serializable_options[key] ||= []
      @serializable_options[key] += value
    end

    # Generates a hash that represents the api response based on this
    # template for the passed model instance.
    def to_response_hash(model, fieldset = self, options = {})
      api_output = model.serializable_hash(serializable_options) if model.respond_to? :serializable_hash
      api_output ||= {}

      fieldset.each do |field, value|
        next unless allowed_to_render?(fieldset, field, model, options)

        out = process_value(model, value, options)

        if out.respond_to?(:as_api_response)
          sub_template = api_template_for(fieldset, field)
          out = out.as_api_response(sub_template, options)
        end

        api_output[field] = out
      end

      api_output
    end
  end
end