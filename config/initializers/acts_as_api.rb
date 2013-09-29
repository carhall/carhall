module ActsAsApi
  module Base
    ClassMethods.module_eval do
      # Determines the attributes, methods of the model that are accessible in the api response.
      # *Note*: There is only whitelisting for api accessible attributes.
      # So once the model acts as api, you have to determine all attributes here that should
      # be contained in the api responses.
      def api_accessible(api_template, options = {}, &block)

        attributes = ApiTemplate.new(api_template)

        attributes.merge!(api_accessible_attributes(options[:extend])) if options[:extend]

        if block_given?
          yield attributes
        end

        class_attribute "api_accessible_#{api_template}".to_sym
        send "api_accessible_#{api_template}=", attributes
      end
      
    end
  end

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

    def serializable(key, value)
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

        set_value(api_output, fieldset, field, out, options)
      end

      api_output
    end

  private
    
    def set_value(api_output, fieldset, field, out, options)
      fieldset_options = fieldset.options_for(field)

      unless fieldset_options[:append_to]
        api_output[field] = out
      else
        fieldset_options[:append_to].to_s.split('.').reduce(api_output) do |sub_output, key|
          sub_output[key.to_sym] ||= {}
        end[field] = out
      end
    end
  end
end