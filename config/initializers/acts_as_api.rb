module ActsAsApi
  module Base
    CacheVersion = 1

    ClassMethods.module_eval do
      # Determines the attributes, methods of the model that are accessible in the api response.
      # *Note*: There is only whitelisting for api accessible attributes.
      # So once the model acts as api, you have to determine all attributes here that should
      # be contained in the api responses.
      def api_accessible(api_template, options = {}, &block)

        attributes = ApiTemplate.new(api_template, options)

        attributes.merge!(api_accessible_attributes(options[:extend])) if options[:extend]

        if block_given?
          yield attributes
        end

        class_attribute "api_accessible_#{api_template}".to_sym
        send "api_accessible_#{api_template}=", attributes

        after_commit do
          Rails.cache.delete([self.class, self.id, api_template, CacheVersion])
        end if options[:cache]
      end

      def as_api_response(api_template, options = {})
        api_includes = (api_accessible_attributes(api_template).includes rescue nil)
        api_cache = (api_accessible_attributes(api_template).cache rescue nil)

        scope = all
        scope = scope.includes(api_includes) if api_includes && !api_cache
        scope.collect do |item|
          if item.respond_to?(:as_api_response)
            item.as_api_response(api_template, options)
          else
            item
          end
        end

      end

    end

    InstanceMethods.module_eval do
      # Creates the api response of the model and returns it as a Hash.
      # Will raise an exception if the passed api template is not defined for the model
      def as_api_response(api_template, options = {})
        api_attributes = self.class.api_accessible_attributes(api_template)
        raise ActsAsApi::TemplateNotFoundError.new("acts_as_api template :#{api_template.to_s} was not found for model #{self.class}") if api_attributes.nil?

        before_api_response(api_template)
        response_hash = around_api_response(api_template) do
          api_attributes.to_response_hash(self, api_attributes, options)
        end
        after_api_response(api_template)

        response_hash
      end

      alias_method :as_api_response_without_cache, :as_api_response
      def as_api_response(api_template, options = {})
        api_cache = (self.class.api_accessible_attributes(api_template).cache rescue nil)
        if api_cache
          Rails.cache.fetch([self.class, self.id, api_template, CacheVersion], expires_in: api_cache) do
            as_api_response_without_cache(api_template, options)
          end
        else
          as_api_response_without_cache(api_template, options)
        end
      end
    end
  end

  ApiTemplate.class_eval do
    attr_reader :serializable_options
    attr_accessor :includes, :cache

    def initialize(api_template, api_options)
      super(api_template)
      @includes = api_options[:includes]
      @cache = api_options[:cache]
      @options ||= {}
      @serializable_options ||= {}
    end

    def merge!(other_hash, &block)
      super
      self.options.merge!(other_hash.options) if other_hash.respond_to?(:options)
      self.serializable_options.merge!(other_hash.serializable_options) if other_hash.respond_to?(:serializable_options)
      self.includes ||= other_hash.includes if other_hash.respond_to?(:includes)
      self.cache ||= other_hash.cache if other_hash.respond_to?(:cache)
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
          out = out.as_api_response(sub_template, sub: true)
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

ActiveRecord::Associations::CollectionProxy.class_eval do

  def as_api_response(api_template, options = {})
    collect do |item|
      if item.respond_to?(:as_api_response)
        item.as_api_response(api_template, options)
      else
        item
      end
    end

  end
end